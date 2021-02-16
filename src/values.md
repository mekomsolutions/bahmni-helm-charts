
#### Values
|Value   |Description   | Default
|---|---|---|
| isAppliance  | This indicates whether we are deploying to the openmrs appliance or a cloud hosting   | true  |
| selectDbHost  |   |   |
| rwxStorageClass  | Used when isAppliance is false to provide a storage class that allows  |mekom-nfs   |
| postgresLocalPath  | Postgres local volume path on the host running postgres  |/mnt/disks/ssd1/data/postgresql   |
| mysqlLocalPath  | Mysql local volume path on the host running postgres   | /mnt/disks/ssd1/data/mysql  |
| databaseHostRole  | The role of the host that will run the DBs used when isAppliance is true  |  |
| nfs.enabled  | Whether to install the nfs server to provide ReadWrite class for the cluster  | true |
| nfs.image  |Image for the nfs server  | enyachoke/nfs-ganesha-server-and-external-provisioner  |
| nfs.hostRole  | Role of the host that will run the nfs server|database   |
| nfs.storageClassNamespace  |Namespace for nfs storage class | mekomsolutions.net/nfs  |
| nfs.nfsStorageClass  | Name of the RWX to be created   |mekom-nfs   |
| nfs.nodeSelector  | Node selector object for placing of the nfs server   |  |
| apps.appointments.enabled  |Whether to install the Bahmni appointments app  |true   |
| apps.appointments.image  |Bahmni appointments Image  |mekomsolutions/appointments   |
| apps.bahmni_config.enabled  | Bahmni Config Enabled  |true   |
| apps.bahmni_config.image  |Bahmni Config Image  |nginx:alpine   |
| apps.bahmni_filestore.enabled  |Bahmni Filestore enabled   |true   |
| apps.bahmni_filestore.image  |Bahmni Filestore Image   |nginx:alpine   |
| apps.bahmni_mart.enabled  | Bahmni mart enabled  |true   |
| apps.bahmni_mart.image  |Bahmni mart image   |mekomsolutions/bahmni-mart   |
| apps.bahmni_mart.ANALYTICS_DB_HOST  |Analytics DB host   |   |
| apps.bahmni_mart.ANALYTICS_DB_NAME  |Analytics DB name   |analytics   |
| apps.bahmni_mart.ANALYTICS_DB_USER  |Analytics Db passoword   |analytics   |
| apps.bahmni_mart.ANALYTICS_DB_PASSWORD  |Analytics Db passoword   |password   |
| apps.bahmni_reports.enabled  |Bahmni reports enabled | true  |
| apps.bahmni_reports.image  |Bahmni Reports Image |mekomsolutions/bahmni-reports   |
| apps.bahmniapps.enabled  | Bahmnui apps  Enabled | true  |
| apps.bahmniapps.image  |Bahmni Apps Image   |mekomsolutions/bahmniapps   |
| apps.implementer_interface.enabled  |Bahmni implementer interface Enabled   | true  |
| apps.implementer_interface.image  |Bahmni implementer interface Image    | mekomsolutions/implementer-interface  |
| apps.metabase.enabled  | Metabase enabled  |true   |
| apps.metabase.image  |Metabase Image    | mekomsolutions/metabase  |
| apps.metabase.METABASE_DB_NAME  |Metabase DB name   |metabase   |
| apps.metabase.METABASE_DB_PASSWORD  |Metabase DB password   | metabase  |
| apps.metabase.METABASE_DB_USER  |Metabase Db user   | metabase  |
| apps.mysql.enabled  |Mysql enabled   |true   |
| apps.mysql.image  | Mysql image   |mariadb:10.3   |
| apps.mysql.MYSQL_ROOT_USER  |Mysql root user   | root  |
| apps.mysql.MYSQL_ROOT_PASSWORD  | Mysql root password   |password   |
| apps.mysql.nodeSelector  |Mysql node selector object   |   |
| apps.mysql.storage.storageClass  |mysql pvc storage class name   |   |
| apps.mysql.storage.size  | Mysql pvc size  |   |
| apps.mysql.storage.annotations  |Mysql custom annotations   |   |
| apps.mysql.storage.nodeAffinity  |Mysql volume node afinity if you are running on the appliance and must ensure the pvc is deployed on the same node as the deployment |   |
| apps.postgresql.enabled  |Postgres enabled   | true  |
| apps.postgresql.image  |Postgres Image   | postgres:9.6-alpine  |
| apps.postgresql.POSTGRES_HOST  |Postgres Host   |   |
| apps.postgresql.POSTGRES_PORT  |Postgres port   |   |
| apps.postgresql.POSTGRES_PASSWORD  |Postgres default password   | password  |
| apps.postgresql.POSTGRES_DB  | Postgres default db   | postgres  |
| apps.postgresql.POSTGRES_USER  | Postgres default user   | postgres  |
| apps.postgresql.nodeSelector  |Postgres default node selector object   |  |
| apps.postgresql.storage.storageClass  | Postgres pv storage class   |   |
| apps.postgresql.storage.size  | Postgres PVC size   |   |
| apps.postgresql.storage.annotations  |Postgres Deployment custom annotations   |   |
| apps.postgresql.storage.nodeAffinity  |Postgres PVC node afinity if you are running on the appliance and must ensure the pvc is deployed on the same node as the deployment |  |
| apps.odoo.enabled  |Odoo enabled  | true  |
| apps.odoo.image  |Odoo Image   |mekomsolutions/odoo   |
| apps.odoo.ODOO_DB_USER  |Odoo DB user   | odoo  |
| apps.odoo.ODOO_DB_PASSWORD  |Odoo DB password   | password  |
| apps.odoo.ODOO_DB_NAME  | Odoo DB name  | odoo  |
| apps.odoo.ODOO_HOST  |Odoo DB host   |   |
| apps.odoo.ODOO_USER  |Odoo User   | admin  |
| apps.odoo.ODOO_PASSWORD  |Odoo user passoword  |admin   |
| apps.odoo.ODOO_MASTER_PASSWORD  |Odoo master passoword   | password  |
| apps.odoo.ODOO_EXTRA_ADDONS  |Odoo extra addons path   |odoo_addons   |
| apps.odoo.ODOO_CONFIG_PATH  | Odoo config path  |odoo_config   |
| apps.odoo_connect.enabled  |Odoo connect enabled   |true   |
| apps.odoo_connect.image  |Odoo connect image   | mekomsolutions/odoo-connect  |
| apps.openelis.enabled  |Openmrs enabled   |true   |
| apps.openelis.image  |Openmrs image   | enyachoke/openelis  |
| apps.openelis.OPENELIS_DB_USER |Openelis db user   |clinlims   |
| apps.openelis.OPENELIS_DB_PASSWORD |Openelis db password | clinlims  |
| apps.openelis.OPENELIS_DB_NAME  |Openelis db name   | clinlims  |
| apps.openelis.OPENELIS_DB_HOST  | Openelis db host  | clinlims  |
| apps.openelis.OPENELIS_ATOMFEED_USER  |Openelis atomfeed user |atomfeed   |
| apps.openelis.OPENELIS_ATOMFEED_PASSWORD  |Openelis atomfeed user passoword   |AdminadMIN*   |
| apps.openmrs.enabled  | Openmrs enabled    | true  |
| apps.openmrs.image  | Openmrs Image  | mekomsolutions/openmrs  |
| apps.openmrs.OPENMRS_DB_NAME  |Openmrs DB name   |openmrs   |
| apps.openmrs.OPENMRS_USER  |Openmrs user   |superman   |
| apps.openmrs.OPENMRS_PASSWORD  |Openmrs password   |Admin123   |
| apps.openmrs.OPENMRS_HOST  |Openmrs Host   |   |
| apps.openmrss.OPENMRS_DB_USER  |Openmrs DB user   | openmrs  |
| apps.openmrs.OPENMRS_DB_HOST  | Openmrs DB host  |   |
| apps.openmrs.OPENMRS_DB_PASSWORD  |Openmrs DB password   |password   |
| apps.openmrs.OPENMRS_OWAS_PATH  |   | openmrs_core  |
| apps.openmrs.OPENMRS_MODULES_PATH  |Openmrs module path   | openmrs_modules  |
| apps.openmrs.OPENMRS_CONFIG_PATH  |   |openmrs_config   |
| apps.openmrs.OPENMRS_CONFIG_CHECKSUMS_PATH  |   |   |
| apps.proxy.enabled  |Proxy enabled   | true  |
| apps.proxy.image  | Proxy Image   | enyachoke/proxy  |