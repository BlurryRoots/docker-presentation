## Entity/Component
## Architecture

by Sven Freiberg



# Warum ?

* Interesse an Spieleprogrammierung
* Medieninformatik Hochschule Trier (UCB)
* Praxis
	* Gam Jams
	* Praxissemester Daedalic



# Übersicht
- Motivation
- Aufbau
- Fazit
- Beispiel



# Motivation


## Engine Design

* Vereinfachte Darstellung
* Logik in ```Update(dt)```
* Anzeige in ```Render()```
* Periodisch aufgerufen


## Traditionelle Architektur

* GO (Game Object) mit unterschiedlichen Ausprägungen


## Traditionelle Architektur

* GO (Game Object) mit unterschiedlichen Ausprägungen

![traditionell](/gfx/newfangled.png)


## Konsequenz

* Logik und Daten gemeinsam verwaltet
* Single Responsibility
* Problematisch bei Sprachen ohne Mehrfachvererbung


## Ableitung

```java
class Spaceship
extends GameObject
implements IRenderable,
		   ICollidable,
		   IControlable {
	// ...
	@Override void onRender (Context ctx) {
		// ...
	}
}
```


## Ansatz

* Vermeiden von Vererbung
* Definition von Objekten per Komposition


## Komposition

```java
class Spaceship
extends GameObject {
	private Renderable renderable;
	private Collidable collidable;
	private Controlable controlable;

	@Override void onUpdate (float dt) {
		renderable.onUpdate (dt);
		collidable.onUpdate (dt);
	}

	@Override void onRender () {
		renderable.render ();
	}
}
```


## Probleme

* Wo sollen GOs verwaltet werden?
* Abhänigkeiten (tight cuppling) von Komponenten
* Überladungsparty wenn mehrere Ebenen
* Starre Architektur


## Probleme

* Designer werden sich kaum an Klassenstruktur halten wollen
* Anforderung werden mit Sicherheit geändert
* Meistens auch gravierendk (Prototyping)


## (Philosophischer) Ansatz

* Spiel ist Datenbank mit glitzernder Benutzeroberfläche

![sc](/gfx/starcraft.png)


## Für dich!

![cookie](/gfx/cookie.png)



# Übersicht
- *Motivation*
- Aufbau
- Fazit
- Beispiel



# Aufbau


## Fokus

* Datengetrieben Architektur


## Ansatz

* Scott Bilas 2002 @ GDC
* Dungeon Siege
* Game Object System 


## Fokus

* Datengetrieben Architektur
* Näher an Designern
* Kein Software Ingenieur nötig
* Maximale Abstraktion von GOs
* Engine ist egal ob GO Monster oder Baum


## Elemente

* Grundelemente Elemente
	* Entities
	* Components
	* Systems
	* Events


## Entities

* Representation eines Game Objects
* Effektiv nur eine ID (ähnlich Datenbank)


## Entities

* Impelemntierung z.B. per Facade Pattern
* Erleichtert OOP Transition

```java
class Entity {
	private long id;
	private EntityManager mgr;

	// ...

	public <T extends Data> void addData (final T someData) {
		mgr.addDataToEntity (this.id, someData);
	}
}
```


## Components/Data

* Beschreiben Ausprägung einer Entity
	* Position/Rotation
	* Lebenspunkte, Rüstung
	* Renderinformationen


## Components/Data

```java
class PhysicsComponent
extends Data {
	public int mass;
	public Vector3 velocity; 
}
```


## Componet hinzufügen

```java
// travels a max of 1337m and hits for 42hp
bullet.addData (new DamageModifier (42, 1337));
```


## Systems/Processors

* Hält Logik verantwortlich für
	* Berechnung einer Komponente
	* Sematische Gruppen von Komponenten


## Systems/Processors

```java
class MovementProcessor extends Processor {
	// ...

	@Override public onProcessing (float dt) {
		List <IEntity> entities =
			this.emgr.getEntitiesWithAspects (Position.class,
											  Physics.class);

		for (IEntity e : entities) {
			Physics phy = e.get (Physics.class);
			Position pos = e.get (Position.class);
			// translate position with respect to passed time
			pos.translate (phy.velocity.multiply (dt));
		}
	}
}
```


## Interprocessor Communication

* Prozessoren müssen in der Lagen sein zu kommunizieren
* Event/Message System
	* Observer Pattern (eher problematisch)
	* Event Queue (gut verzögerbar)


## Event Dispatching

Schematische Darstellung

![events](/gfx/events.png)



# Übersicht
- Motivation
- Aufbau
- *Fazit*
- *Beispiel*



# Fazit


### Pros

* Leicht erweiterbar
	* Generierung neuer 'Typen' via Kombination
* Änderung des Verhalten von Entitäten
	* Austausch von Komponenten
* Übersichtliche Abbildung Komplexer Game Objects
* Gute Einbindung in Editoren


### Cons

* Hoher initialer Aufwand (inkl. Pardigmengewöhnung)
* Overhead wenn starr datengetrieben
* Hohes Potenzial für Spaghetti Code
	* Abhängigkeit von Komponenten
	* Reihenfolge von Processoren
	* Messagepassing



## Meinung

* Mächtige Architektur
* Vorsichtig einsetzen
* Kein Allheilmittel



# Übersicht
- Motivation
- Aufbau
- Fazit
- *Beispiel*



# Beispiele


## Frameworks

* Frameworks
	* Arthemis (Java, C#, ObjC)
	* Yanecos (Java, C#, C++)
* Engines
	* Dungeon Siege (1)
	* Unity



# Referenzen

* Data-Driven Game Object System
	- Scott Bilas
	- http://scottbilas.com/files/2002/gdc_san_jose/game_objects_slides_with_notes.pdf
* Entity Systems are the future of MMOG development
	- Adam Martin
	- http://t-machine.org/index.php/2007/09/03/entity-systems-are-the-future-of-mmog-development-part-1/


# Referenzen

* Evolve your Hirachy (!)
	- Mick West
	- http://cowboyprogramming.com/2007/01/05/evolve-your-heirachy/
* Case Study: Bomberman Mechanics in an ECS
	- Philip Fortier
	- http://www.gamedev.net/page/resources/_/technical/game-programming/case-study-bomberman-mechanics-in-an-entity-component-system-r3159


# Referenzen

* Rogue Basins Wiki Entry
	- http://www.roguebasin.com/index.php?title=Entity_Component_System
* Wikipedia Entry
	- https://en.wikipedia.org/wiki/Entity_component_system
* Starcraft Screenshot
	- http://static.giantbomb.com/uploads/original/0/1468/184087-starcraft.png


# Referenzen

* Kravall
	- Core Engine Design
	- http://kravall.autious.net/?p=148
* Entity/Component Primer
	- http://piemaster.net/2011/07/entity-component-primer/



# Danke !

Fragen oder Anmerkungen ?
