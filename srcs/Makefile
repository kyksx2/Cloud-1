NAME = Inception
COMPOSE = docker compose -f docker-compose.yml

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

re: clean all

prune:
	@docker system prune -af
	@docker volume prune -f

.PHONY: all up down restart logs clean re prune