FROM docker/compose:latest

COPY docker-compose.yml /docker-compose.yml

CMD ["up", "--build"]
