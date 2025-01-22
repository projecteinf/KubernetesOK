
# hostnamectl set-hostname workeri
dnf install kernel-devel-$(uname -r)
modprobe br_netfilter
modprobe ip_vs
modprobe ip_vs_rr
modprobe ip_vs_wrr
modprobe ip_vs_sh
modprobe overlay
cat > /etc/modules-load.d/kubernetes.conf << EOF
br_netfilter
ip_vs
ip_vs_rr
ip_vs_wrr
ip_vs_sh
overlay
EOF

cat > /etc/sysctl.d/kubernetes.conf << EOF
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
setenforce 0
sysctl --system
swapoff -a
sed -e '/swap/s/^/#/g' -i /etc/fstab
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf makecache
dnf -y install containerd.io
sh -c "containerd config default > /etc/containerd/config.toml" ; cat /etc/containerd/config.toml
vi /etc/containerd/config.toml 
systemctl enable --now containerd.service
systemctl status containerd.service
firewall-cmd --zone=public --permanent --add-port=6443/tcp
firewall-cmd --zone=public --permanent --add-port=2379-2380/tcp
firewall-cmd --zone=public --permanent --add-port=10250/tcp
firewall-cmd --zone=public --permanent --add-port=10251/tcp
firewall-cmd --zone=public --permanent --add-port=10252/tcp
firewall-cmd --zone=public --permanent --add-port=10255/tcp
firewall-cmd --zone=public --permanent --add-port=5473/tcp
firewall-cmd --reload
systemctl stop firewalld
systemctl disable firewalld
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/repodata/repomd.xml.key
# exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF

dnf makecache; dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable --now kubelet.service
# kubeadm join 172.20.1.1:6443 --token 96cixr.3zgsvlrx2wbswgpo --discovery-token-ca-cert-hash sha256:e4319857d3cfdd5507d10de89fa1546af4f940f9acb8b19cafd6bb0b7f8fd0e4
