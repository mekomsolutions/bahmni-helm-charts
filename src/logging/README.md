### Installation
The installation uses hostpath in the node with role database
create the folder for log storage

```mkdir -p /mnt/disks/ssd1/logging```

Apply the  manifests in this folder to setup the logging stack.

```kubectl apply -f ./```

This will install a fluentd daemonset and rsyslog server in the namespace ```rsyslog```

To get the logs

```NAMESPACE="rsyslog"  ../scripts/download-files.sh mdlh/alpine-rsync ./logs/  logging-pvc```

This will download the logs into the folder ```./logs```