# Demo 01 - Getting started with Flyway migrations using Docker
# 
#   1- Create PostgreSQL container with BudgetFoods empty shell database
#   2- Connect to PostgreSQL using psql (within Docker)
#   3- Execute basic PostgreSQL commands
#   4- Review Flyway migrations folder structure
#   5- Flyway migrations using Docker containers (V1 - BudgetFoods)
#   6- Flyway migrations using Docker containers (V2 - BudgetFoods)
#   7- Check BudgetFoods schema changes
#   8- Redo migrations (all at once)
#   9- Check PostgreSQL BudgetFoods database schema
# -----------------------------------------------------------------------------
# Reference:
#   https://flywaydb.org/documentation/
#   https://github.com/flyway/flyway-docker
#   https://hub.docker.com/r/flyway/flyway
#   https://github.com/pthom/northwind_psql
#
# JDBC URL
# PostgreSQL:       jdbc:postgresql://<host>:<port>/<database>?<key1>=<value1>&<key2>=<value2>

# 0- Env variables | demo path
cd ~/Documents/Redgate-Flyway/Demo_01;
SQLScripts=~/Documents/Redgate-Flyway/Demo_01/SQLScripts;
ConfigFile=~/Documents/Redgate-Flyway/Demo_01/ConfigFile;

# Environment Cleanup 
# dkrm BudgetFoods-PG;
# docker volume rm vlm_PG-Data;
# mv ./SQLScripts/V2.1__Load-CustomerRelated-data.sql ./SQLScripts/_V2.1__Load-CustomerRelated-data.sql;
# mv ./SQLScripts/V2.2__Load-ProductsRelated-data.sql ./SQLScripts/_V2.2__Load-ProductsRelated-data.sql;
# mv ./SQLScripts/V2.3__Load-RegionsRelated-data.sql ./SQLScripts/_V2.3__Load-RegionsRelated-data.sql;

# 1- Create PostgreSQL container with BudgetFoods empty shell database
docker container run \
    --name BudgetFoods-PG \
    --hostname BudgetFoods-PG \
    --env POSTGRES_DB=BudgetFoods \
    --env 'POSTGRES_PASSWORD=CmdL1n3-r0ck5' \
    --volume vlm_PG-Data:/var/lib/postgresql/data \
    --publish 5432:5432 \
    --detach postgres:12-alpine

# 2- Connect to PostgreSQL using psql (within Docker)
docker exec -it BudgetFoods-PG psql -U postgres -d BudgetFoods

# 3- Execute basic PostgreSQL commands
# List all databases
# psql command: \list | \l
SELECT datname FROM pg_database;

# List all tables in BudgetFoods     
# psql command: \dtables | \dt
SELECT table_name FROM information_schema.tables where table_schema ='public';

# Exit psql session
# psql command: \quit | \q
quit;

# 4- Review Flyway migrations folder structure
Demo_01
├── ConfigFile
│   └── flyway.conf
└── SQLScripts
    ├── V1.1__Create-CustomerRelated-Tables.sql
    ├── V1.2__Create-ProductRelated-Tables.sql
    ├── V1.3__Create-RegionsRelated-Tables.sql
    ├── _V2.1__Load-CustomerRelated-data.sql    --> Not visible to Flyway
    ├── _V2.2__Load-ProductsRelated-data.sql    --> Not visible to Flyway
    └── _V2.3__Load-RegionsRelated-data.sql     --> Not visible to Flyway

# Flyway config file
code ./ConfigFile/flyway.conf

# Migrations (SQL scripts)
code ./SQLScripts/V1.1__Create-CustomerRelated-Tables.sql;
code ./SQLScripts/V1.2__Create-ProductRelated-Tables.sql;
code ./SQLScripts/V1.3__Create-RegionsRelated-Tables.sql;

# 5- Flyway migrations using Docker containers (V1 - BudgetFoods)
# Flyway application structure
flyway
├── lib
├── licenses
├── conf
│   └── flyway.conf         --> Configuration file
├── drivers                 --> JDBC drivers
├── flyway                  --> macOS/Linux executable
├── jars                    --> Java-based migrations (as jars)
└── sql
    └── V1_Migration.sql    --> SQL-based migrations

# Environment variables
# SQLScripts=~/Documents/Redgate-Flyway/Demo_01/SQLScripts;
# ConfigFile=~/Documents/Redgate-Flyway/Demo_01/ConfigFile;

# Initializing flyway
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway info

# Perform V1 migration
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway migrate

# Check status
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway info

# Check database structures
docker exec -it BudgetFoods-PG psql -U postgres -d BudgetFoods -c "\dt"
docker exec -it BudgetFoods-PG \
    psql -U postgres -d BudgetFoods \
    -c "SELECT version, description, script, installed_on FROM public.flyway_schema_history;"

# 6- Flyway migrations using Docker containers (V2 - BudgetFoods)
# Add more scripts
code ./SQLScripts/_V2.1__Load-CustomerRelated-data.sql;
code ./SQLScripts/_V2.2__Load-ProductsRelated-data.sql;
code ./SQLScripts/_V2.3__Load-RegionsRelated-data.sql;

mv ./SQLScripts/_V2.1__Load-CustomerRelated-data.sql ./SQLScripts/V2.1__Load-CustomerRelated-data.sql;
mv ./SQLScripts/_V2.2__Load-ProductsRelated-data.sql ./SQLScripts/V2.2__Load-ProductsRelated-data.sql;
mv ./SQLScripts/_V2.3__Load-RegionsRelated-data.sql  ./SQLScripts/V2.3__Load-RegionsRelated-data.sql;

# Updated folder structure
Demo_01
├── ConfigFile
│   └── flyway.conf
└── SQLScripts
    ├── V1.1__Create-CustomerRelated-Tables.sql
    ├── V1.2__Create-ProductRelated-Tables.sql
    ├── V1.3__Create-RegionsRelated-Tables.sql
    ├── V2.1__Load-CustomerRelated-data.sql --> Visible to Flyway
    ├── V2.2__Load-ProductsRelated-data.sql --> Visible to Flyway
    └── V2.3__Load-RegionsRelated-data.sql  --> Visible to Flyway

# Check status
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway info

# Perform V2 migration
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway migrate

# --------------------------------------
# Azure Data Studio step
# --------------------------------------
# 7- Check BudgetFoods schema changes

# 8- Redo migrations (all at once)
# Clean all previous migrations
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway clean

# Check status
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway info

# Perform all migrations
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway migrate

# Check status
docker container run --rm \
    --volume $SQLScripts:/flyway/sql \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway info

# 9- Check PostgreSQL BudgetFoods schema
docker exec -it BudgetFoods-PG \
    psql -U postgres -d BudgetFoods \
    -c "SELECT version, description, script, installed_on FROM public.flyway_schema_history;"