### Running a local registry

If you are running in an air-gapped environment without access to the internet you may need to run an in-cluster registry.  In our example we will be persisting the images using a host volume on a node with label 'database'
#### Create folder for persisting images on the node with label 'database'

```mkdir -p /mnt/disks/ssd1/registry```

### Apply the registry manifests
If you are not on this folder cd to it before continuing with the following commands which assume you are running within this folder.
Modify ```loadBalancerIP``` in the file ```service.yaml``` to reflect the subnet mask of your cluster loadbalancer. Then apply the manifests

```kubectl apply -f .```
This creates the pvc ,deployment and a service accessible at ```192.168.0.99```

### Update K3s to be able to pull images from our in cluster registry

On all the nodes edit/create ```/etc/rancher/k3s/registries.yaml```

```nano /etc/rancher/k3s/registries.yaml```

to add this content

```
mirrors:
  "192.168.0.99":
    endpoint:
      - http://192.168.0.99
```

### Downloading images.
We use https://github.com/containers/skopeo to manage the images so you will need to have it in your path.The file ```images.txt``` contains the images required by this project you can add any other image you may need to it.
Download images from docker

```cat ./images.txt | ../scripts/download-images.sh ./images```

Upload images to in cluster registry

```skopeo sync --dest-tls-verify=false --src dir --dest docker ./images/ 192.168.0.99/```

See the file ```custom-values.yaml.example``` for an example of a values file to override images when generating manifests using helm.

