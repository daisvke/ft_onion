# Use 'docker compose' if you are using the plugin,
# otherwise use 'docker-compose'
COMPOSE			= docker compose
# COMPOSE = sudo docker-compose

# The base docker compose YAML file
BASE_YML		= docker-compose.yml

.PHONY: all build up nonpersist clean fclean re


# ****************************
#         BUILD RULES
# ****************************

all: up

# The following two recipes shut down containers if up,
# build all images if not build and run detached containers

# Run container in hostname persistent mode
up:
	mkdir -p tor_data/hidden_service/
	cp -R tor_data/saved_hidden_service/* tor_data/hidden_service/
	$(COMPOSE) -f $(BASE_YML) up -d --build
	rm -rf tor_data/hidden_service/*

# Stops containers without deleting anything
stop:
	$(COMPOSE) stop

# Stops and removes containers without deleting volumes/images
down:
	$(COMPOSE) down

# Restart and rebuild containers
restart: down up


# ****************************
#  ONION ADDRESS PERSISTENCY
# ****************************

# Run container in non-persistent mode (use new onion address on rebuild)
nonpersist:
	$(COMPOSE) -f $(BASE_YML) up -d --build

tor-export:
	rm -rf tor_data/hidden_service/*
	@echo "Exporting Tor hidden service identity..."
	docker cp tor_service:/var/lib/tor/hidden_service/. tor_data/hidden_service_export


# ****************************
#         CLEAN RULES
# ****************************

# Shut all containers down and delete them
clean:
	@echo "\033[33mCleaning...\033[0m"
	$(COMPOSE) down -v --rmi all --remove-orphans 2> /dev/null

# Clean and delete all unused volumes, containers, networks and images
fclean: clean
	docker system prune --volumes --all --force 2> /dev/null
	# sudo docker system prune --volumes --all --force 2> /dev/null

re: fclean all