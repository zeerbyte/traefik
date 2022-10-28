# Reverse Proxy with Traefik
This container serve as a proxy server using [traefik](https://traefik.io/) for local development. It also uses [traefik.me](https://traefik.me) ssl certificate.

The docker compose file includes two services ```traefik``` and ```proxy-helper```. The ```proxy-helper``` only runs a command to copy the certificate and key to the shared volume, so ```traefik``` service can use them.

You can start both the services with ```docker compose up -d```. If you are like me and don't want to see a service that is not running, then you can run and remove the ```proxy-helper``` service and the run only the ```traefik``` service.

```
# Create the volumes for certificates and copy them
docker compose run --rm proxy-helper

# Start traefik only
docker compose up -d traefik
```

To make a little bit easier there is a makefile that does this for you, so just run the command ```make```. A network called ```traefik``` is created in this container and should be included in any container meant to use the reverse proxy.

Once the container is running you can find Traefik Dashboard at https://dashboard.traefik.me.

Finally to run a docker container with the reverse proxy add in the ```docker-compose.yml``` file the required labels to enable traefik and define the host rule. As an example you can follow the ```docker-compose.yml``` file in this repository.

```
version: '3'
services:
    traefik:
        ...
        labels:
            - traefik.enable=true
            - traefik.http.routers.dashboard.rule=HostRegexp(`dashboard.traefik.me`, `dashboard-{dashed-ip:.*}traefik.me`)
            - traefik.http.routers.dashboard.tls.domains[0].main=dashboard.traefik.me
            - traefik.http.routers.dashboard.tls.domains[0].sans=dashboard-*.traefik.me
            - traefik.http.services.dashboard.loadbalancer.server.port=8080
        ...
        networks:
            ...
            - traefik
        ...
networks:
    traefik:
        external: true
```

This container also allows you to have access to the virtual hosts from any device within your network. For more information check [traefik.me](https:/traefik.me).

