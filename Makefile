# Use 'docker compose' if you are using the plugin,
# otherwise use 'docker-compose'
COMPOSE							= docker compose
# COMPOSE = sudo docker-compose

# The base docker compose YAML file
BASE_YML						= docker-compose.yml
# For address persistency
HIDDEN_SERVICE_PATH_HOST		= tor_data/hidden_service
# Path to the folder where we previously saved Tor data
SAVED_HIDDEN_SERVICE_PATH_HOST	= tor_data/saved_hidden_service
# Where Tor files are exported
HIDDEN_SERVICE_EXPORT_PATH		= tor_data/hidden_service_export
LOG_FILES						= logs/auth.log logs/fail2ban.log config/ssh/authorized_keys
WEBSITE_PATH					= html/slate

.PHONY: all build up stop start down restart nonpersist tor-export clean-tor clean fclean re


# ****************************
#         BUILD RULES
# ****************************

all: up

# The following two recipes shut down containers if up,
# build all images if not build and run detached containers

# Run container in hostname persistent mode
#
# - Copy the saved hidden service identity to the temporary folder
# - Build/run the containers
# - Delete the temporary folder
up: setup
	mkdir -p $(HIDDEN_SERVICE_PATH_HOST)
	@if [ -d "$(SAVED_HIDDEN_SERVICE_PATH_HOST)" ] && [ "$$(find $(SAVED_HIDDEN_SERVICE_PATH_HOST) -type f | wc -l)" -gt 0 ]; then \
			echo "Copying hidden service files..."; \
			cp -R $(SAVED_HIDDEN_SERVICE_PATH_HOST)/* $(HIDDEN_SERVICE_PATH_HOST); \
		else \
			echo "No hidden service files to copy, skipping."; \
	fi
	$(COMPOSE) -f $(BASE_YML) up -d --build
	rm -rf $(HIDDEN_SERVICE_PATH_HOST)/*


# Stops containers without deleting anything
stop:
	$(COMPOSE) stop

# Stops and removes containers without deleting volumes/images
down:
	$(COMPOSE) down

# Restart and rebuild containers
restart: down up

# Create empty log files in case they don't exist
# Create the .env file for the website
setup:
	touch $(LOG_FILES)
	cp $(WEBSITE_PATH)/.env.example $(WEBSITE_PATH)/.env


# ****************************
#  ONION ADDRESS PERSISTENCY
# ****************************

# Run container in non-persistent mode (use new onion address on rebuild)
nonpersist: setup
	$(COMPOSE) -f $(BASE_YML) up -d --build

tor-export:
	rm -rf $(HIDDEN_SERVICE_PATH_HOST)/*
	@echo "Exporting Tor hidden service identity..."
	docker cp tor_service:/var/lib/tor/hidden_service/. $(HIDDEN_SERVICE_EXPORT_PATH)


# ****************************
#         CLEAN RULES
# ****************************

clean-tor:
	rm -rf $(SAVED_HIDDEN_SERVICE_PATH_HOST)/* $(HIDDEN_SERVICE_PATH_HOST)/*

# Shut all containers down and delete them
clean:
	@echo "\033[33mCleaning...\033[0m"
	$(COMPOSE) down -v --rmi all --remove-orphans 2> /dev/null

# Clean and delete all unused volumes, containers, networks and images
fclean: clean
	docker system prune --volumes --all --force 2> /dev/null
	# sudo docker system prune --volumes --all --force 2> /dev/null

re: fclean all
