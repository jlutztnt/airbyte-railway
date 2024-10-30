version: '3.7'

services:
  airbyte-temporal:
    image: temporalio/auto-setup:1.7.0
    environment:
      - DYNAMIC_CONFIG_FILE_PATH=config/dynamicconfig/development.yaml
      - DB=postgresql
      - DB_PORT=5432
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PWD=${POSTGRES_PASSWORD}
      - POSTGRES_SEEDS=${DATABASE_URL}
    ports:
      - "7233:7233"

  airbyte-server:
    image: airbyte/server:0.50.24
    environment:
      - AIRBYTE_VERSION=0.50.24
      - DATABASE_USER=${POSTGRES_USER}
      - DATABASE_PASSWORD=${POSTGRES_PASSWORD}
      - DATABASE_URL=${DATABASE_URL}
      - TEMPORAL_HOST=airbyte-temporal:7233
      - WEBAPP_URL=${RAILWAY_PUBLIC_DOMAIN}
      - MICRONAUT_ENVIRONMENTS=control-plane
      - DATABASE_PROPERTIES='{"ssl":true}'
      - airbyte.workspace.root=/data
      - CONFIG_ROOT=/config
    ports:
      - "8001:8001"
    depends_on:
      - airbyte-temporal

  airbyte-worker:
    image: airbyte/worker:0.50.24
    environment:
      - AIRBYTE_VERSION=0.50.24
      - DATABASE_USER=${POSTGRES_USER}
      - DATABASE_PASSWORD=${POSTGRES_PASSWORD}
      - DATABASE_URL=${DATABASE_URL}
      - TEMPORAL_HOST=airbyte-temporal:7233
      - WORKSPACE_ROOT=/data
      - CONFIG_ROOT=/config
    depends_on:
      - airbyte-temporal
      - airbyte-server

  airbyte-webapp:
    image: airbyte/webapp:0.50.24
    environment:
      - AIRBYTE_VERSION=0.50.24
      - API_URL=${RAILWAY_PUBLIC_DOMAIN}/api
      - INTERNAL_API_HOST=airbyte-server:8001
      - CONNECTOR_BUILDER_API_URL=https://connectors.airbyte.com/files/registries/v0
    ports:
      - "80:80"
    depends_on:
      - airbyte-server
