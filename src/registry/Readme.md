### Installation

The installation uses hostpath in the node with role database
create the folder for the registry

```/mnt/disks/ssd1/registry```

### Example ync images to local registry with skopeo

```mkdir images```

```skopeo sync --src docker --dest dir docker.io/busybox:latest ./images``

```skopeo sync --dest-tls-verify=false --src dir --dest docker images/ 192.168.0.99/```


Test with docker on host if available

Add ```192.168.0.99``` as an insecure registry

run

```docker pull 192.168.0.99/ubuntu```

Update k3s 

```nano /etc/rancher/k3s/registries.yaml```

```
mirrors:
  "192.168.0.99":
    endpoint:
      - http://192.168.0.99
```

