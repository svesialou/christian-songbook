.PHONY: build docker-build docker-run docker-stop docker-logs docker-prepare stack-build stack-up stack-down stack-logs stack-health backend-build backend-up backend-down backend-logs backend-health db-migrate db-rollback ngrok-prod ngrok-stop ngrok-fresh ngrok-url

IMAGE_NAME ?= christian-songbook
IMAGE_TAG ?= latest
CONTAINER_NAME ?= christian-songbook
PORT ?= 8081
NGROK_PID_FILE ?= .ngrok.pid
DOCKER_COMPOSE ?= docker compose
MYSQL_CONTAINER ?= christian-songbook-mysql
MYSQL_DATABASE ?= christian_songbook
MYSQL_USER ?= songbook
MYSQL_PASSWORD ?= songbook
WEB_PORT ?= 8083

build:
	npm run build

docker-build:
	docker build --platform linux/amd64 -t $(IMAGE_NAME):$(IMAGE_TAG) .

docker-run:
	docker rm -f $(CONTAINER_NAME) >/dev/null 2>&1 || true
	docker run -d --name $(CONTAINER_NAME) -p $(PORT):80 $(IMAGE_NAME):$(IMAGE_TAG)

docker-stop:
	docker stop $(CONTAINER_NAME)
	docker rm $(CONTAINER_NAME)

docker-logs:
	docker logs -f $(CONTAINER_NAME)

stack-build:
	$(DOCKER_COMPOSE) build web backend

stack-up:
	$(DOCKER_COMPOSE) up -d --build mysql backend web

stack-down:
	$(DOCKER_COMPOSE) down

stack-logs:
	$(DOCKER_COMPOSE) logs -f web backend mysql

stack-health:
	curl -fsS http://127.0.0.1:$(WEB_PORT)/
	curl -fsS http://127.0.0.1:$(WEB_PORT)/api/catalog/snapshot >/dev/null
	curl -fsS http://127.0.0.1:8082/readyz

backend-build:
	$(DOCKER_COMPOSE) build backend

backend-up:
	$(DOCKER_COMPOSE) up -d mysql backend

backend-down:
	$(DOCKER_COMPOSE) down

backend-logs:
	$(DOCKER_COMPOSE) logs -f backend mysql

backend-health:
	curl -fsS http://127.0.0.1:8082/healthz
	curl -fsS http://127.0.0.1:8082/readyz

db-migrate:
	@for migration in migrations/*.up.sql; do \
		echo "Applying $$migration"; \
		docker exec -i -e MYSQL_PWD=$(MYSQL_PASSWORD) $(MYSQL_CONTAINER) mysql --default-character-set=utf8mb4 -u$(MYSQL_USER) $(MYSQL_DATABASE) < "$$migration" || exit $$?; \
	done

db-rollback:
	@for migration in $$(ls migrations/*.down.sql | sort -r); do \
		echo "Rolling back $$migration"; \
		docker exec -i -e MYSQL_PWD=$(MYSQL_PASSWORD) $(MYSQL_CONTAINER) mysql --default-character-set=utf8mb4 -u$(MYSQL_USER) $(MYSQL_DATABASE) < "$$migration" || exit $$?; \
	done

ngrok-prod:
	ngrok http $(PORT)

ngrok-stop:
	-pkill -f "ngrok http $(PORT)" || true
	@if [ -f "$(NGROK_PID_FILE)" ]; then \
		PID=$$(cat "$(NGROK_PID_FILE)"); \
		kill "$${PID}" >/dev/null 2>&1 || true; \
		rm -f "$(NGROK_PID_FILE)"; \
	fi

ngrok-fresh:
	$(MAKE) ngrok-stop
	@nohup ngrok http $(PORT) >/tmp/christian-songbook-ngrok.log 2>&1 & echo $$! > $(NGROK_PID_FILE)
	@echo "ngrok запущен в фоне, pid=$$(cat $(NGROK_PID_FILE)); лог: /tmp/christian-songbook-ngrok.log"
	@sleep 1
	$(MAKE) ngrok-url

ngrok-url:
	@TMP_JSON="$$(mktemp /tmp/christian-songbook-ngrok-XXXXXX.json)"; \
	if ! curl -fsS http://127.0.0.1:4040/api/tunnels > "$$TMP_JSON"; then \
		rm -f "$$TMP_JSON"; \
		echo "ngrok API unavailable on 127.0.0.1:4040. Start tunnel first: make ngrok-fresh"; \
		echo "No active ngrok tunnels. Start with: make ngrok-fresh"; \
	else \
		python3 -c "import json; msg='No active ngrok tunnels. Start with: make ngrok-fresh'; d=json.load(open('$$TMP_JSON')); tunnels=d.get('tunnels',[]); urls=[t.get('public_url') for t in tunnels if t.get('public_url') and t.get('proto') in ('https','http')]; print(next((u for u in urls if u), msg))"; \
		rm -f "$$TMP_JSON"; \
	fi
