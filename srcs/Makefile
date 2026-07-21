NAME = Inception
COMPOSE = docker compose -f ./docker-compose.yml
VOLUME = /home/kjolly/data/wordpress /home/kjolly/data/mariadb

all: up

up:
	mkdir -p $(VOLUME)
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

prune:
	@docker system prune -af
	@docker volume prune -f

.PHONY: all up down restart logs clean re prune