# Demo 02 - Flyway migrations on CI/CD pipelines
# 
#   1- Review repository structure
#   2- Review Kubernetes deployments
#   3- Update web app image
#   4- Check rolling upgrade status
#   5- Check rollout history
#   6- Review Flyway schema history
#   7- Copy new migrations to SQL scripts folder
#   8- Review Flyway new migrations structure
#   9- Review Flyway migrations - SQL files
#   10- Review Flyway migrations - Kubernetes job
#   11- Push changes to repository
#   12- Watch pipeline in Jenkins
#   13- Check Flyway migration job status
#   14- Review Flyway schema history
#   15- Review changes in PostgreSQL GeoKids database
#   16- Review GeoKids website
# -----------------------------------------------------------------------------
# Reference:
#   https://flywaydb.org/documentation/
#   https://github.com/flyway/flyway-docker
#   https://hub.docker.com/r/flyway/flyway

# 0- Env variables | demo path
cd ~/Documents/Redgate-Flyway/Demo_03;
ConfigFile=~/Documents/Redgate-Flyway/Demo_03/ConfigFile;
GeoKidsDB=`kubectl get service geokids-db-service | grep geokids-db | awk {'print $4'}`;
GeoKidsWeb=`kubectl get service geokids-web-service | grep geokids-web-service | awk {'print $4'}`;

0- Environment Cleanup
# docker container run --rm \
#     --volume $ConfigFile:/flyway/conf \
#     flyway/flyway clean
# rm -rf ./SQLScripts/V2.1__Add-FlagColumn-CountriesTable.sql
# rm -rf ./SQLScripts/V2.2__Load-CountryFlags-Data.sql
# rm -rf ./SQLScripts/V2.3__Create-ViewStructures.sql

# 1- Review repository structure
Demo_03
├── Dockerfile
├── Jenkinsfile
├── Jobs
│   └── dbmigration-job.yaml
├── SQLScripts
│   ├── V1.1__Create-TableStructures.sql
│   └── V1.2__Load-TableData.sql
└── v2-SQLScripts
    ├── V2.1__Add-FlagColumn-CountriesTable.sql         --> Not part of migrations
    ├── V2.2__Load-CountryFlags-Data.sql                --> Not part of migrations
    └── V2.3__Create-ViewStructures.sql                 --> Not part of migrations

# 2- Review Kubernetes deployments
# Get all deployments
kubectl get deployments

# Describe web app deployment
kubectl describe deployment geokids-web-deployment

# Get current image
kubectl describe deployment geokids-web-deployment | grep Image

# 3- Update web app image
kubectl --record deployment set image geokids-web-deployment geokids-web=geokids/geokids-web:2.0

# 4- Check rolling upgrade status
kubectl rollout status -w deployment geokids-web-deployment
kubectl get pods | grep -i geokids-web-deployment

# 5- Check rollout history
kubectl rollout history deployment geokids-web-deployment

# 6- Review Flyway schema history
psql -h $GeoKidsDB -U geokids -c \
    "SELECT version, description, script, installed_on, success FROM public.flyway_schema_history;"

# 7- Copy new migrations to SQL scripts folder
cp ./v2-SQLScripts/V2.1__Add-FlagColumn-CountriesTable.sql ./SQLScripts;
cp ./v2-SQLScripts/V2.2__Load-CountryFlags-Data.sql ./SQLScripts;
cp ./v2-SQLScripts/V2.3__Create-ViewStructures.sql ./SQLScripts;

# 8- Review Flyway new migrations structure
Flyway migration
├── Jobs
│   └── dbmigration-job.yaml
└── SQLScripts
    ├── V1.1__Create-GeoKids-TableStructures.sql
    ├── V1.2__Load-GeoKids-TableData.sql
    ├── V2.1__Add-FlagColumn-CountriesTable.sql         --> New database version
    ├── V2.2__Load-CountryFlags-Data.sql                --> New database version
    └── V2.3__Create-ViewStructures.sql                 --> New database version

# 9- Review Flyway migrations - SQL files
# Database Version# 2
code ./SQLScripts/V2.1__Add-FlagColumn-CountriesTable.sql
code ./SQLScripts/V2.2__Load-CountryFlags-Data.sql
code ./SQLScripts/V2.3__Create-ViewStructures.sql

# 10- Review Flyway migrations - Kubernetes job
code ./Jobs/dbmigration-job.yaml

# 11- Push changes to repository
git add .
git commit -m "Adding new version of database migrations"
git push --force

# 12- Watch pipeline in Jenkins
open https://github.com/geo-kids/geokids-prod-migrations
open http://138.91.191.121:8080/blue/pipelines

# 13- Check Flyway migration job status
# Getting all kubernetes jobs
kubectl get jobs

# Describing last migration job (Kubernetes job)
migration_job=`kubectl get jobs --sort-by=.metadata.creationTimestamp | tail -1 | awk '{print $1}'`
kubectl describe job $migration_job

# Checking Flyway migration logs (Kubernetes pod)
migration_pod=$(kubectl get pods --selector=job-name=$migration_job --output=jsonpath='{.items[*].metadata.name}')
echo $migration_pod
kubectl logs $migration_pod -f

# 14- Review Flyway schema history
psql -h $GeoKidsDB -U geokids -c \
    "SELECT version, description, script, installed_on, success FROM public.flyway_schema_history;"

# 15- Review changes in PostgreSQL GeoKids database
psql -h $GeoKidsDB -U geokids -c "\dt"
psql -h $GeoKidsDB -U geokids -c "\d+ countries"

# 16- Review GeoKids website
open http://$GeoKidsWeb:8083