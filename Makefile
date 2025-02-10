# Use 'docker compose' if you are using the plugin,
# otherwise use 'docker-compose'
COMPOSE = docker compose
# COMPOSE = sudo docker-compose

.PHONY: all build up clean fclean re

all: up

# Build/rebuild an image
build:
	$(COMPOSE) build

# Shut down containers if up, build all images and run detached containers
up:
	$(COMPOSE) up -d --build

# Shut all containers down and delete them
clean:
	@echo "\033[33mCleaning...\033[0m"
	$(COMPOSE) down -v --rmi all --remove-orphans 2> /dev/null

# Clean and delete all unused volumes, containers, networks and images
fclean: clean
	docker system prune --volumes --all --force 2> /dev/null
	# sudo docker system prune --volumes --all --force 2> /dev/null

re: fclean all