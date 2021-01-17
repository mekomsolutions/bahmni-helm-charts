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

```$ cd ../```

### Setup nfs storage class

```kubectl apply -f ./nfs```

Wait until the nfs-provisioner pod starts

```kubectl get pods```


```nfs-provisioner-0   1/1     Running   0          5m31s```

### Generating Kubernetes manifests from the helm-chart

```helm template haiti bahmni-helm --output-dir haiti-distro  ```

#### Values
|Value   |Description   | Default
|---|---|---|
| isAppliance  |   |   |
| selectDbHost  |   |   |
| rwxStorageClass  |   |   |
| postgresLocalPath  |   |   |
| mysqlLocalPath  |   |   |
| databaseHostRole  |   |   |
| nfs.enabled  |   |   |
| nfs.image  |   |   |
| nfs.hostRole  |   |   |
| nfs.storageClassNamespace  |   |   |
| nfs.nfsStorageClass  |   |   |
| nfs.nodeSelector  |   |   |
| apps.appointments.enabled  |   |   |
| apps.appointments.image  |   |   |
| apps.bahmni_config.enabled  |   |   |
| apps.bahmni_config.image  |   |   |
| apps.bahmni_filestore.enabled  |   |   |
| apps.bahmni_filestore.image  |   |   |
| apps.bahmni_mart.enabled  |   |   |
| apps.bahmni_mart.ANALYTICS_DB_HOST  |   |   |
| apps.bahmni_mart.ANALYTICS_DB_NAME  |   |   |
| apps.bahmni_mart.ANALYTICS_DB_PASSWORD  |   |   |
| apps.bahmni_reports.enabled  |   |   |
| apps.bahmni_reports.image  |   |   |
| apps.bahmniapps.enabled  |   |   |
| apps.bahmniapps.image  |   |   |
| apps.implementer_interface.enabled  |   |   |
| apps.implementer_interface.image  |   |   |
| apps.metabase.enabled  |   |   |
| apps.metabase.image  |   |   |
| apps.metabase.METABASE_DB_NAME  |   |   |
| apps.metabase.METABASE_DB_PASSWORD  |   |   |
| apps.metabase.METABASE_DB_USER  |   |   |
| apps.mysql.enabled  |   |   |
| apps.mysql.image  |   |   |
| apps.mysql.MYSQL_ROOT_USER  |   |   |
| apps.mysql.MYSQL_ROOT_PASSWORD  |   |   |
| apps.mysql.nodeSelector  |   |   |
| apps.mysql.storage.storageClass  |   |   |
| apps.mysql.storage.size  |   |   |
| apps.mysql.storage.annotations  |   |   |
| apps.mysql.storage.nodeAffinity  |   |   |
| apps.postgresql.enabled  |   |   |
| apps.postgresql.image  |   |   |
| apps.postgresql.POSTGRES_HOST  |   |   |
| apps.postgresql.POSTGRES_PORT  |   |   |
| apps.postgresql.POSTGRES_PASSWORD  |   |   |
| apps.postgresql.POSTGRES_DB  |   |   |
| apps.postgresql.POSTGRES_USER  |   |   |
| apps.postgresql.nodeSelector  |   |   |
| apps.postgresql.storage.storageClass  |   |   |
| apps.postgresql.storage.size  |   |   |
| apps.postgresql.storage.annotations  |   |   |
| apps.postgresql.storage.nodeAffinity  |   |   |
| apps.odoo.enabled  |   |   |
| apps.odoo.image  |   |   |
| apps.odoo.ODOO_DB_USER  |   |   |
| apps.odoo.ODOO_DB_PASSWORD  |   |   |
| apps.odoo.ODOO_DB_NAME  |   |   |
| apps.odoo.ODOO_HOST  |   |   |
| apps.odoo.ODOO_USER  |   |   |
| apps.odoo.ODOO_PASSWORD  |   |   |
| apps.odoo.ODOO_MASTER_PASSWORD  |   |   |
| apps.odoo.ODOO_EXTRA_ADDONS  |   |   |
| apps.odoo.ODOO_CONFIG_PATH  |   |   |
| apps.odoo_connect.enabled  |   |   |
| apps.odoo_connect.image  |   |   |
| apps.openelis.enabled  |   |   |
| apps.openelis.image  |   |   |
| apps.openelis.OPENELIS_DB_USER |   |   |
| apps.openelis.OPENELIS_DB_PASSWORD |   |   |
| apps.openelis.OPENELIS_DB_NAME  |   |   |
| apps.openelis.OPENELIS_DB_HOST  |   |   |
| apps.openelis.OPENELIS_ATOMFEED_USER  |   |   |
| apps.openelis.OPENELIS_ATOMFEED_PASSWORD  |   |   |
| apps.openelis.enabled  |   |   |
| apps.openelis.image  |   |   |
| apps.openelis.OPENMRS_DB_NAME  |   |   |
| apps.openelis.OPENMRS_USER  |   |   |
| apps.openelis.OPENMRS_PASSWORD  |   |   |
| apps.openelis.OPENMRS_HOST  |   |   |
| apps.openelis.OPENMRS_DB_USER  |   |   |
| apps.openelis.OPENMRS_DB_HOST  |   |   |
| apps.openelis.OPENMRS_DB_PASSWORD  |   |   |
| apps.openelis.OPENMRS_OWAS_PATH  |   |   |
| apps.openelis.OPENMRS_MODULES_PATH  |   |   |
| apps.openelis.OPENMRS_CONFIG_PATH  |   |   |
| apps.openelis.OPENMRS_CONFIG_CHECKSUMS_PATH  |   |   |
| apps.proxy.enabled  |   |   |
| apps.proxy.image  |   |   |









### Deploy configs and resources
````kubectl apply -f ./haiti-distro/bahmni-helm/templates/resources```

```kubectl apply -f ./haiti-distro/bahmni-helm/templates/configs```

```kubectl apply -f ./haiti-distro/bahmni-helm/templates/common```

```kubectl apply -f ./haiti-distro/bahmni-helm/templates/apps/ -R```

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

```scripts/krsync -av --progress --stats distro  $POD_NAME:/distro ```

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

