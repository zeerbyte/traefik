# Reverse Proxy with Traefik
This container serve as a proxy server using [traefik](https://traefik.io/) for for local development. It also uses [traefik.me](https://traefik.me) ssl certificate.

The docker compose file includes two services ```traefik``` and ```proxy-helper```. The ```proxy-helper``` only runs a command to copy the certificate and key to the shared volume, so ```traefik``` service can use them.

You can start both the services with ```docker compose up -d```. If you are like me and don't want to see a service that is not running, then you can run and remove the ```proxy-helper``` service and the run only the ```traefik``` service.

```
# Create the volumes for certificates and copy them
docker compose run --rm proxy-helper

# Start traefik only
docker compose up -d traefik
```

To make a little bit easier there is a makefile that does this for you, so just run the command ```make```.