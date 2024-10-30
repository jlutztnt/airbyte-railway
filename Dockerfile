FROM airbyte/server:0.50.24

# Install requirements
RUN apt-get update && apt-get install -y \
    docker-compose \
    && rm -rf /var/lib/apt/lists/*

# Copy configuration
COPY docker-compose.yml /docker-compose.yml

# Set environment variables
ENV AIRBYTE_VERSION=0.50.24
ENV DATABASE_USER=${POSTGRES_USER}
ENV DATABASE_PASSWORD=${POSTGRES_PASSWORD}
ENV DATABASE_URL=${DATABASE_URL}
ENV WEBAPP_URL=${RAILWAY_PUBLIC_DOMAIN}
ENV MICRONAUT_ENVIRONMENTS=control-plane
ENV DATABASE_PROPERTIES='{"ssl":true}'

EXPOSE 8001
CMD ["docker-compose", "up"]
