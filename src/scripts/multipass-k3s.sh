#!/usr/bin/env bash
multipass launch --name k3s --cpus 6 --mem 6g --disk 25g
multipass exec k3s -- bash -c "curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh - && sudo apt-get -y  install unzip nfs-common"
multipass exec k3s sudo cat /etc/rancher/k3s/k3s.yaml > k3s.yaml
K3S_IP=$(multipass info k3s | grep IPv4 | awk '{print $2}')
sed -i '' "s/127.0.0.1/${K3S_IP}/" k3s.yaml