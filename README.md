# ft_onion

## Requirements
- Docker
- Docker Compose
- Make

```bash

# You will need this structure from /var/lib/tor/hidden_service/ to run it with hostname persistence
├── tor_data
│   ├── authorized_clients
│   ├── hostname
│   ├── hs_ed25519_public_key
│   └── hs_ed25519_secret_key

# To get the generated hostname by Tor
docker exec -it tor_service cat /var/lib/tor/hidden_service/hostname

# Run container in hostname persistent mode
Make up

# Run container in hostname nonpersistent mode
Make nonpersist

# Execute bash from the container
docker exec -it tor_service /bin/bash
```

## References
* [Set up Your Onion Service (torproject.org)](https://community.torproject.org/onion-services/setup/)
* [docker-compose reference YAML file with comments](https://gist.github.com/ju2wheels/1885539d63dbcfb20729)