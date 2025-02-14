
```bash
# To get the generated hostname by Tor
docker exec -it tor_service cat /var/lib/tor/hidden_service/hostname

# Necessary permissions
sudo chmod -R 700 tor_data
sudo chown -R debian-tor:debian-tor tor_data

```
