build-amd64:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 docker run --rm -v `pwd`:/plugin-source tykio/tyk-plugin-compiler:v5.1.2 logger-plugin.so
build-arm64:
	DOCKER_DEFAULT_PLATFORM=linux/amd64 docker run --rm --env GOARCH=arm64 --env GOOS=linux --env CGO_ENABLED=1 --env CC=clang -v `pwd`:/plugin-source tykio/tyk-plugin-compiler:v5.1.2 logger-plugin.so
build-local:
	cd plugins/logger/go && go build -buildmode=plugin -trimpath -o test.so
bundle:
	docker run --rm -it \
	--name bundler \
	-v `pwd`:/plugin-source \
	-v `pwd`/../../../confs/keys:/keys \
	-w /plugin-source \
	--entrypoint /bin/bash \
	tykio/tyk-gateway:v5.1.2 \
	-c 'export PATH="/opt/tyk-gateway:$$PATH"; tyk bundle build -o logger.zip -k /keys/key.pem'
