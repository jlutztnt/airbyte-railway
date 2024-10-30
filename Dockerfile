FROM airbyte/webapp:0.50.24

ENV AIRBYTE_VERSION=0.50.24
ENV PORT=3000
ENV API_URL=${RAILWAY_PUBLIC_DOMAIN}
ENV INTERNAL_API_HOST=airbyte-server
ENV CONNECTOR_BUILDER_API_URL=${RAILWAY_PUBLIC_DOMAIN}
ENV CLOUD=false
ENV API_URL=/api
ENV MARKETPLACE_ENDPOINT=https://connectors.airbyte.com/files/registries/v0
ENV CLOUD_API_URL=/cloud-api
ENV VERSION=0.50.24

EXPOSE 3000
