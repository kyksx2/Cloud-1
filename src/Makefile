NAME = Inception
COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	@$(COMPOSE) up -d --build

down:
	@$(COMPOSE) down

restart:
	@$(COMPOSE) down
	@$(COMPOSE) up -d --build

logs:
	@$(COMPOSE) logs

clean:
	@$(COMPOSE) down -v --rmi all
	@sudo rm -rf $(VOLUME)

re: clean all

.PHONY: all up down restart logs clean re