# Usage
## Deploying locally using multipass and K3s
### Setup local node
Install [Multipass](https://multipass.run/docs)

```$ git clone https://github.com/mekomsolutions/k8s-description-files```

```$ cd k8s-description-files/src/scripts```

```$ ./multipass-k3s.sh```

Copy the kubectl config to ~/.kube/ and set ```KUBECONFIG```

```$ cp k3s.yaml  ~/.kube/k3s```

```$ export KUBECONFIG=~/.kube/k3s```

``` $ kubectl get nodes```

```
Should return
NAME   STATUS   ROLES    AGE     VERSION
k3s    Ready    master   5m12s   v1.19.5+k3s2
```
Label the node that will hold datbase volumes and store nfs data

```kubectl label node k3s role=database```

Create nfs and data volumes

```multipass exec k3s -- sudo mkdir -p /mnt/disks/ssd1/nfs```

```multipass exec k3s -- sudo mkdir -p /mnt/disks/ssd1/data/postgresql```

```multipass exec k3s -- sudo mkdir -p /mnt/disks/ssd1/data/mysql```


### Generating Kubernetes manifests from the helm-chart

```helm template haiti bahmni-helm --output-dir haiti-distro  ```

#### Values
|Value   |Description   | Default
|---|---|---|
| isAppliance  | This indicates whether we are deploying tothe openmrs appliance or a cloud hosting   | true  |
| selectDbHost  |   |   |
| rwxStorageClass  | Used when isAppliance is false to provide a storage class that allows  |mekom-nfs   |
| postgresLocalPath  | Postgres local volume path on the host running postgres  |/mnt/disks/ssd1/data/postgresql   |
| mysqlLocalPath  | Mysql local volume path on the host running postgres   | /mnt/disks/ssd1/data/mysql  |
| databaseHostRole  | The role of the host that will run the DBs used when isAppliance is true  |database   |
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

```cd ./haiti-distro/bahmni-helm/templates```

### Setup nfs storage class

```kubectl apply -f ./nfs```

Wait until the nfs-provisioner pod starts

```kubectl get pods```


```nfs-provisioner-0   1/1     Running   0          5m31s```

### Deploy configs and resources
```kubectl apply -f ./resources```

```kubectl apply -f ./configs```

```kubectl apply -f ./common```

```kubectl apply -f ./apps/ -R```

Wait until all pods are in running state

```kubectl get pods```

```
nfs-provisioner-0                        1/1     Running   0          11h
svclb-odoo-2wc74                         1/1     Running   0          10h
svclb-openelis-tbcxv                     1/1     Running   0          10h
svclb-proxy-hlbmg                        1/1     Running   0          10h
svclb-metabase-tng5m                     1/1     Running   0          10h
bahmni-filestore-7c9c67cc5b-s95jg        1/1     Running   0          10h
bahmni-config-55579d5c4f-g8vgp           1/1     Running   0          10h
postgres-5f7fcc748f-4mds6                1/1     Running   0          10h
proxy-6fc6f9899d-dgc7x                   1/1     Running   0          10h
implementer-interface-64d8cc9cf6-29m7f   1/1     Running   0          10h
bahmniapps-64c5fffc75-vfp77              1/1     Running   0          10h
appointments-786579bb57-n7xvd            1/1     Running   0          10h
mysql-7d5c68b846-ldhxv                   1/1     Running   0          10h
bahmni-reports-6545644dc-kk5ww           1/1     Running   0          10h
bahmni-mart-884d4dd94-n8v4m              1/1     Running   0          10h
openmrs-6b69884945-gvg77                 1/1     Running   0          10h
metabase-59b479486f-ckbtl                1/1     Running   0          9h
odoo-549cdf79bb-lmpww                    1/1     Running   0          10h
odoo-connect-7fd78b48f-lvv7z             1/1     Running   0          9h
openelis-97cbdf4c8-mmpwg                 1/1     Running   0          40m
```

Get the system endpoints

```kubectl get svc | grep 'LoadBalancer```

```
odoo                    LoadBalancer   10.43.121.169   192.168.64.7   8069:31354/TCP                                                                                              10h
openelis                LoadBalancer   10.43.175.49    192.168.64.7   8080:30984/TCP                                                                                              10h
proxy                   LoadBalancer   10.43.143.157   192.168.64.7   8000:30618/TCP                                                                                              10h
metabase                LoadBalancer   10.43.159.202   192.168.64.7   3000:30884/TCP                                                                                              10h
```
In this case

Bahmni is accessinle via the proxy http://192.168.64.7:8000

Odoo via odoo http://192.168.64.7:8069 

Metabase via metabase http://192.168.64.7:3000 

Openelis via openelis http://192.168.64.7:8080

## Managing files using the update container
The update container is a helper container that attaches the distro and data volumes which contain distro configurations and applications data respectively you will need rsync installed to use the helper script and avoid using ```kubectl cp```

### Uploading distro configurations
To upload configs using the bahmni-distro-haiti

Get the update pod name

```export POD_NAME=$(kubectl get pods -l name=haiti-update-container -o=jsonpath='{.items..metadata.name}')```

Get The config

```wget https://nexus.mekomsolutions.net/repository/maven-releases/net/mekomsolutions/bahmni-distro-haiti/1.0.0/bahmni-distro-haiti-1.0.0.zip```

Create the unzip destination

```mkdir distro```

```unzip bahmni-distro-haiti-1.0.0.zip -d distro```

Upload the new configs

```scripts/krsync -av --progress --stats distro/  $POD_NAME:/distro/ ```

This will sync the local distro folder with the distro folder on the update container


You need to scale down and then scale up your openmrs deployment to force it to restart

```kubectl get deployment```

Should return something like

```
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
haiti-odoo-connect            1/1     1            1           16h
nginx                         1/1     1            1           13h
haiti-implementer-interface   1/1     1            1           16h
haiti-bahmni-config           1/1     1            1           16h
haiti-bahmni-filestore        1/1     1            1           16h
haiti-update-container        1/1     1            1           16h
haiti-bahmni-reports          1/1     1            1           16h
haiti-bahmniapps              1/1     1            1           16h
haiti-metabase                1/1     1            1           16h
haiti-openelis                1/1     1            1           16h
haiti-odoo                    1/1     1            1           16h
haiti-proxy                   1/1     1            1           16h
haiti-bahmni-mart             1/1     1            1           16h
haiti-openmrs                 1/1     1            1           16h
```

For this case run

```kubectl scale deployment haiti-openmrs --replicas 0```

followed by

```kubectl scale deployment haiti-openmrs --replicas 1```

To scale it back up. This will force the OpenMRS pod to be recreated restarting OpenMRS


### Download files from the container's data folder

```scripts/krsync -av --progress --stats  $POD_NAME:/data data```
This could be used to download backups and other files.

#### NOTE: Sometimes this command my fail if the pipe to the pod breaks when using ```kubectl cp``` This will fail silently and there is no way to know that the copy failed. With this helper it will fail with a non zero error code

