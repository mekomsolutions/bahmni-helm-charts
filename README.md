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

### Deploy configs and resources
```kubectl apply -f ./resources```
```kubectl apply -f ./configs```
```kubectl get pvc```

Should return something like

```
data-pvc     Bound    pvc-b40d13f6-da60-4df9-96be-a01a09918642   5Gi        RWX            mekom-nfs      19s
distro-pvc   Bound    pvc-4e4725bf-75dd-4761-912a-8601839c19ce   2Gi        RWX            mekom-nfs      19s
```
**Note the id of distro-pvc for the next step**
### Download configs
```multipass exec k3s -- bash```

```cd /mnt/disks/ssd1/nfs/pvc-4e4725bf-75dd-4761-912a-8601839c19ce```

Replace ```pvc-4e4725bf-75dd-4761-912a-8601839c19ce``` with id of distro-pvc

### Retrieve the Bahmni distribution of your choice:

The Docker images do not provide a default Bahmni distribution so you need to first fetch one.
You have multiple options available:

- Clone and build one of the Bahmni Distros ([Haiti](https://github.com/mekomsolutions/bahmni-distro-haiti), [C2C](https://github.com/mekomsolutions/bahmni-distro-c2c) , [HSC](https://github.com/CRUDEM/bahmni-distro-hsc), [Cambodia](https://github.com/mekomsolutions/openmrs-distro-cambodia)...)

- or manually download the Zip distro from Nexus:
https://nexus.mekomsolutions.net/#browse/search=name.raw%3Dbahmni-distro-*

We will use bahmni-distro-haiti for this setup

```sudo apt-get install unzip```

```wget https://nexus.mekomsolutions.net/repository/maven-releases/net/mekomsolutions/bahmni-distro-haiti/1.0.0/bahmni-distro-haiti-1.0.0.zip```

```unzip bahmni-distro-haiti-1.0.0.zip```

```rm bahmni-distro-haiti-1.0.0.zip```

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

### Uploading local configs
The setup has a pod for uploading [https://github.com/mekomsolutions/openmrs-module-initializer 
](openmrs-module-initializer) it is a busyboxy mounting the configs pvc at ```/distro``` to upload configs using the bahmni-distro-haiti example

Get the update pod name

```export POD_NAME=$(kubectl get pods -l name=update-container -o=jsonpath='{.items..metadata.name}')```

Get The config

```wget https://nexus.mekomsolutions.net/repository/maven-releases/net/mekomsolutions/bahmni-distro-haiti/1.0.0/bahmni-distro-haiti-1.0.0.zip```

Create the unzip destination

```mkdir distro```

**Note this actually has to be called distro due to limitations of the ```kubectl cp``` command**

```unzip bahmni-distro-haiti-1.0.0.zip -d distro```

Clean the configs directory

```kubectl exec $POD_NAME -- sh -c 'rm -rf /distro/*' ```

Copy the new configs

```kubectl cp distro  $POD_NAME:/ ```

