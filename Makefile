gen-keys:
	openssl genpkey -algorithm RSA -out ./confs/keys/key.pem
	openssl rsa -pubout -in ./confs/keys/key.pem -out ./confs/keys/public_key.pem
go-down:
	docker-compose -f docker-compose.go.yml down
go-logs:
	docker-compose -f docker-compose.go.yml logs
go-restart:
	docker-compose -f docker-compose.go.yml restart
go-up:
	docker-compose -f docker-compose.go.yml up -d
js-down:
	docker-compose -f docker-compose.js.yml down
js-logs:
	docker-compose -f docker-compose.js.yml logs
js-up:
	docker-compose -f docker-compose.js.yml up -d
js-restart:
	docker-compose -f docker-compose.js.yml restart
python-down:
	docker-compose -f docker-compose.python.yml down
python-logs:
	docker-compose -f docker-compose.python.yml logs
python-up:
	docker-compose -f docker-compose.python.yml up -d
python-restart:
	docker-compose -f docker-compose.python.yml restart
	