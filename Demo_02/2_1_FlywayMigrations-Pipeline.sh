# Demo 02 - Flyway migrations on CI/CD pipelines - V1
# 
#   1- Review repository structure
#   2- Review Kubernetes architecture
#   3- Connect and show PostgreSQL GeoKids empty shell database
#   4- Connect to GeoKids webapp
#   5- Review Dockerfile
#   6- Review Jenkinsfile (pipeline)
#   7- Review Flyway migrations structure
#   8- Review Flyway migrations - SQL files
#   9- Review Flyway migrations - Kubernetes job
#   10- Make changes to repository
#   11- Watch pipeline in Jenkins
#   12- Check Flyway migration job status
#   13- Review Flyway schema history
#   14- Review changes in PostgreSQL GeoKids database
# -----------------------------------------------------------------------------
# Reference:
#   https://flywaydb.org/documentation/
#   https://github.com/flyway/flyway-docker
#   https://hub.docker.com/r/flyway/flyway

# 0- Env variables | demo path
cd ~/Documents/Redgate-Flyway/Demo_02;
ConfigFile=~/Documents/Redgate-Flyway/Demo_02/ConfigFile;
GeoKidsDB=`kubectl get service geokids-db-service | grep geokids-db | awk {'print $4'}`;
GeoKidsWeb=`kubectl get service geokids-web-service | grep geokids-web-service  | awk {'print $4'}`;

Environment Cleanup 
docker container run --rm \
    --volume $ConfigFile:/flyway/conf \
    flyway/flyway clean

# 1- Review repository structure
Demo_02
├── Dockerfile
├── Jenkinsfile
├── Jobs
│   └── dbmigration-job.yaml
└── SQLScripts
    ├── V1.1__Create-TableStructures.sql
    └── V1.2__Load-TableData.sql

# 2- Review Kubernetes architecture
# Kubernetes services
kubectl get services

# Kubernetes deployments
kubectl get deployments
kubectl describe deployment/geokids-db-deployment
kubectl describe deployment/geokids-web-deployment

# Flyway configuration file
kubectl get secret geokidsdb-flyway-config
kubectl describe secrets/geokidsdb-flyway-config
kubectl get secret geokidsdb-flyway-config -o yaml

# JSON format
{
    "apiVersion": "v1",
    "kind": "Secret",
    "metadata": {
        "annotations": {},
        "name": "geokidsdb-flyway-config",
        "namespace": "default"
    },
    "stringData": {
        "flyway.conf": 
            "flyway.url=jdbc:postgresql://<hostname>:5432/geokids
            flyway.user=geokids
            flyway.password=CmdL1n3-r0ck5"
    },
    "type": "Opaque"
}

# 3- Connect and show PostgreSQL GeoKids empty shell database
# Getting databases on PostgreSQL database 
psql -h $GeoKidsDB -U geokids -c "SELECT datname FROM pg_database;"
psql -h $GeoKidsDB -U geokids -c "SELECT table_name FROM information_schema.tables where table_schema ='public';"
psql -h $GeoKidsDB -U geokids -c "\dt"
psql -h $GeoKidsDB -U geokids -c "SELECT CURRENT_USER , inet_server_addr() host ,inet_server_port() port;"

# 4- Connect to GeoKids webapp
open http://$GeoKidsWeb:8083

# 5- Review Dockerfile
code Dockerfile

# 6- Review Jenkinsfile (pipeline)
code Jenkinsfile

# 7- Review Flyway migrations structure
Flyway migration
├── Jobs
│   └── dbmigration-job.yaml
└── SQLScripts
    ├── V1.1__Create-TableStructures.sql
    └── V1.2__Load-TableData.sql

# 8- Review Flyway migrations - SQL files
# Database Version# 1
code ./SQLScripts/V1.1__Create-TableStructures.sql
code ./SQLScripts/V1.2__Load-TableData.sql

# 9- Review Flyway migrations - Kubernetes job
code ./Jobs/dbmigration-job.yaml

# 10- Push changes to repository
git add .
git commit -m "Making changes to trigger CI/CD"
git push --force

# 11- Watch pipeline in Jenkins
open https://github.com/geo-kids/geokids-prod-migrations
open http://138.91.191.121:8080/blue/pipelines

# 12- Check Flyway migration job status
# Getting all kubernetes jobs
kubectl get jobs

# Describing last migration job (Kubernetes job)
migration_job=`kubectl get jobs --sort-by=.metadata.creationTimestamp | tail -1 | awk '{print $1}'`
kubectl describe job $migration_job

# Checking Flyway migration logs (Kubernetes pod)
migration_pod=$(kubectl get pods --selector=job-name=$migration_job --output=jsonpath='{.items[*].metadata.name}')
echo $migration_pod
kubectl logs $migration_pod -f

# 13- Review Flyway schema history
psql -h $GeoKidsDB -U geokids -c \
    "SELECT version, description, script, installed_on, success FROM public.flyway_schema_history;"

# 14- Review changes in PostgreSQL GeoKids database
psql -h $GeoKidsDB -U geokids -c "\dt"

# 15- Review GeoKids website
open http://$GeoKidsWeb:8083