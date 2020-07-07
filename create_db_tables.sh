#!/bin/bash
DB_SCHEMA_SCRIPT="sql/c2.8.1.sql"
docker-compose exec  app sh -c  'mkdir -p /var/www/sites/eramba_community/app/webroot/{files,backups}' #criaçao de pastas dentro de container para evitar volumes
docker-compose exec  app sh -c  'mkdir -p /var/www/sites/eramba_community/app/tmp/logs' 
CONTAINER=$(docker inspect -f '{{.Name}}' $(docker-compose ps -q db) | cut -c2-)
#ver o nome do processo 
docker exec -i ${CONTAINER} sh -c \
    'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"' < ${DB_SCHEMA_SCRIPT}
