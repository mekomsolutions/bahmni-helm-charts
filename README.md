# k8s-description-files
Kubernetes files to describe the cluster specifications and other information
# Running Locally with MicroK8s
brew install ubuntu/microk8s/microk8s
multipass launch --name microk8s-vm --cpus 4 --mem 4G --disk 40G
multipass shell microk8s-vm
sudo snap install microk8s --classic --channel=1.18/stable
sudo iptables -P FORWARD ACCEPT
sudo apt install nfs-kernel-server unzip -y
sudo mkdir -p /mnt/disks/ssd1/data
sudo mkdir -p /mnt/disks/ssd1/distro
sudo echo "/mnt/disks/ssd1/data 192.168.64.0/24(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports
sudo echo "/mnt/disks/ssd1/distro 192.168.64.0/24(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports
Permissions
sudo chown nobody:nogroup /mnt/disks/ssd1/data
sudo chmod 777 /mnt/disks/ssd1/distro
sudo exportfs -a
sudo service nfs-kernel-server restart


sudo mkdir -p /mnt/disks/ssd1/data/mysql
sudo mkdir -p /mnt/disks/ssd1/data/postgresql

exit
microk8s enable dns ingress
microk8s config > ~/.kube/microk8s
export KUBECONFIG=~/.kube/microk8s
kubectl get nodes
```microk8s-vm   Ready    <none>   17m   v1.18.9```
Set node label for db volumes
kubectl label node microk8s-vm role=database
##Download configs
multipass shell microk8s-vm
cd /mnt/disks/ssd1/distro
sudo wget -o distro.zip https://nexus.mekomsolutions.net/repository/maven-snapshots/net/mekomsolutions/bahmni-distro-haiti/1.1.0-SNAPSHOT/bahmni-distro-haiti-1.1.0-20201209.173219-4.zip 
unzip distro.zip
rm distro.zip
exit
 
update 
./config/data-volume.yml
./configs/distro-volume.yml
to set the 
kubectl apply -f ./ -R
# Running on Openmrs Appliance
# Running In the cloud
