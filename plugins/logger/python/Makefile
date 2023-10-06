setup:
	python3 -m venv .venv
	. .venv/bin/activate
	pip3 install protobuf grpcio
bundle:
	docker run --rm -it \
	--name bundler \
	-v `pwd`:/plugin-source \
	-v `pwd`/../../../confs/keys:/keys \
	-w /plugin-source \
	--entrypoint /bin/bash \
	tykio/tyk-gateway:v5.1.2 \
	-c 'export PATH="/opt/tyk-gateway:$$PATH"; tyk bundle build -o logger.zip -k /keys/key.pem'