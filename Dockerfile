FROM airbyte/webapp:0.50.24

ENV PORT=80
ENV API_URL=${RAILWAY_PUBLIC_DOMAIN}/api
ENV INTERNAL_API_HOST=${RAILWAY_PUBLIC_DOMAIN}
ENV CONNECTOR_BUILDER_API_URL=https://connectors.airbyte.com/files/registries/v0

EXPOSE 80
