start: certs
	docker compose up -d traefik
certs:
	docker compose run --rm proxy-helper