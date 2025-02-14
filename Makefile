# Use 'docker compose' if you are using the plugin,
# otherwise use 'docker-compose'
COMPOSE		= docker compose
# COMPOSE = sudo docker-compose

BASE_YML	= docker-compose.yml
PERSIST_YML	= docker-compose.override.yml

.PHONY: all build up clean fclean re

all: up

# The following two recipes shut down containers if up,
# build all images if not build and run detached containers

# Run container in hostname persistent mode
up:
	$(COMPOSE) -f $(BASE_YML) -f $(PERSIST_YML) up -d --build

# Run container in hostname nonpersistent mode
nonpersist:
	$(COMPOSE) -f $(BASE_YML) up -d --build

# Shut all containers down and delete them
clean:
	@echo "\033[33mCleaning...\033[0m"
	$(COMPOSE) down -v --rmi all --remove-orphans 2> /dev/null

# Clean and delete all unused volumes, containers, networks and images
fclean: clean
	docker system prune --volumes --all --force 2> /dev/null
	# sudo docker system prune --volumes --all --force 2> /dev/null

re: fclean all