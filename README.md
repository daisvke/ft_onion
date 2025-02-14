# ft_onion
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
```
