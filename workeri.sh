#!/bin/bash
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
swapoff -a
# Verificació
free -h

# FALTA VERIFICACIÓ

hostnamectl set-hostname workeri

# FALTA VERIFICACIÓ

# COMPROVACIÓ FIREWALL
## Firewall: ufw
ufw status 2>/dev/null
if [ $? -eq 0]
	then
		echo "FAILURE: ufw firewall activated"
		exit 1
fi

echo "SUCCESS: ufw firewall inactive"

## Firewall: firewalld
systemctl status firewalld 2>/dev/null
if [ $? -eq 0]
	then
		echo "FAILURE: firewalld firewall activated"
		exit 2
fi

echo "SUCCESS: firewalld firewall inactive"

## Firewall: firewalld
iptables -L -n 2>/dev/null
if [ $? -eq 0]
	then
		echo "FAILURE: firewall rules found"
		exit 3
fi

echo "SUCCESS: firewall rules not found" 

# CONFIGURACIÓ IP STATICA

echo "
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

auto enp1s0
iface enp1s0 inet static
	address 172.20.1.2
	netmask 255.255.0.0
" | tee /etc/network/interfaces

ifdown enp1s0
ifup enp1s0

# FALTA VERIFICACIÓ
# CONFIGURACIÓ DNS A TRAVÉS DE FITXER HOSTS

echo "172.20.1.1      master
172.20.1.2      workeri
172.20.1.3      workerii" | tee -a /etc/hosts

## Modifcar entrada amb nom debian per master

sed -i 's/\bdebian\b/workeri/' /etc/hosts

## Comprovació configuració

ping -c 3 master 2>/dev/null

if [ $? -eq 1 ]
	then
		echo "FAILURE: fitxer hosts configurat de forma no correcte"
		exit 4
fi

echo "SUCCESS: fitxer hosts configurat de forma correcte"

# INSTAL·LACIÓ REPOSITORIS PER KUBERNETES

apt-get update && apt-get install -y apt-transport-https curl

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list

apt-get update

# INSTAL·LACIÓ KUBELET

apt-get install -y kubelet

## Verificació instal·lació kubelet

kubelet --version 2>/dev/null

if [ $? -ne 0 ]
	then
		echo "FAILURE: kubelet installation failed"
		exit 5
fi

echo "SUCCESS: kubelet installed"

# INSTAL·LACIÓ KUBEADM
apt-get install -y kubeadm

## Verificació instal·lació kubeadm

kubeadm version 2>/dev/null

if [ $? -ne 0 ]
	then
		echo "FAILURE: kubeadm installation failed"
		exit 6
fi

echo "SUCCESS: kubeadm installed"

## Verificació instal·lació kubectl

kubectl version --client 2>/dev/null

if [ $? -ne 0 ]
        then
                echo "FAILURE: kubectl installation failed"
                exit 7
fi

echo "SUCCESS: kubectl installed"

# CONGELAR VERSIONS

apt-mark hold kubelet 
apt-mark hold kubeadm
apt-mark hold kubectl

# FALTA VERIFICACIÓ


modprobe br_netfilter
echo "br_netfilter" | tee -a /etc/modules-load.d/k8s.conf
echo "net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1 " | tee -a /etc/modules-load.d/k8s.conf

# FALTA VERIFICACIÓ

# HABILITAR IP FORWARD
## Habilitació temporal 
echo 1 | tee /proc/sys/net/ipv4/ip_forward

## Habilitació fixe 
echo "net.ipv4.ip_forward = 1" | tee -a /etc/sysctl.conf

## Aplicar canvis
sysctl -p

# FALTA VERIFICACIÓ

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F


mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/debian $(lsb_release -cs) stable" | \
tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install containerd.io

mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml

CONFIG_FILE="/etc/containerd/config.toml"

if [[ -f $CONFIG_FILE ]]; then
    # Substitueix el valor de SystemdCgroup per true
    sed -i '/plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options/,/}/ s/SystemdCgroup = false/SystemdCgroup = true/' $CONFIG_FILE
else
    echo "FAILURE: El fitxer $CONFIG_FILE no existeix. Assegura't que containerd està configurat."
    exit 9
fi

echo "runtime-endpoint: unix:///run/containerd/containerd.sock" | tee /etc/crictl.yaml

systemctl restart containerd
