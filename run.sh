#/bin/bash

# run
docker run -p 8000:8000 \
	-v `pwd`/slides/:/opt/presentation/slides \
	-v `pwd`/gfx/:/opt/presentation/gfx \
	presi
