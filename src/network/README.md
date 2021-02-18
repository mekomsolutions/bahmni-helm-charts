## Installation
This manifests will install [Metallb](https://metallb.universe.tf/) a baremetal cluster to provide [Load Balancing](https://kubernetes.io/docs/concepts/services-networking/) capabilities to your cluster allowing you to use service type LoadBalancer to expose services outside you cluster.

## Using with K3s
K3s comes with a convenient inbuilt loadbalancer that uses hostPort to expose services this fine when running on a lab envronmemt and can make sure your service ports don't conflict. In production it may be more convenient to let all the services listen on their default ports. To [disable](https://rancher.com/docs/k3s/latest/en/networking/#disabling-the-service-lb) the loadbalancer start K3s with the switch ```-disable servicelb```

To install this manifest edit the file ```01-metallb-config.yaml``` to change address section reserved IP pools in your network. The file already has the pool ```192.168.0.10-192.168.0.99``` which will most likely be different inside your network. After that 
run. 

```kubectl apply -f .```

On first install only

```kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"```

After this

```kubectl get pods -n metallb-system```

Returns something like this 

```
controller-65db86ddc6-5csfj   1/1     Running   11         13d
speaker-7drqd                 1/1     Running   11         13d
speaker-dkgq5                 1/1     Running   11         13d
speaker-vvxkh                 1/1     Running   11         13d

```
