    1  cd /etc/NetworkManager/
    2  ls
    3  ls conf.d/
    4  ip a
    5  find . -name ens4
    6  ls
    7  ls system-connections/
    8  vi system-connections/ens4.nmconnection 
    9  shutdown -r now
   10  clear
   11  hostnamectl set-hostname workeri
   12  hostname
   13  vi /etc/hosts 
   14  cat /etc/host
   15  cat /etc/hosts
   16  dnf install kernel-devel-$(uname -r)
   17  sudo modprobe br_netfilter
   18  sudo modprobe ip_vs
   19  sudo modprobe ip_vs_rr
   20  sudo modprobe ip_vs_wrr
   21  sudo modprobe ip_vs_sh
   22  sudo modprobe overlay
   23  cat > /etc/modules-load.d/kubernetes.conf << EOF
br_netfilter
ip_vs
ip_vs_rr
ip_vs_wrr
ip_vs_sh
overlay
EOF

   24  cat > /etc/sysctl.d/kubernetes.conf << EOF
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

   25  sysctl --system
   26  sudo swapoff -a
   27  sed -e '/swap/s/^/#/g' -i /etc/fstab
   28  sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
   29  sudo dnf makecache
   30  [200~sudo dnf -y install containerd.io
   31  sudo sh -c "containerd config default > /etc/containerd/config.toml" ; cat /etc/containerd/config.toml
   32  sudo dnf -y install containerd.io
   33  sudo sh -c "containerd config default > /etc/containerd/config.toml" ; cat /etc/containerd/config.toml
   34  vi /etc/containerd/config.toml 
   35  systemctl enable --now containerd.service
   36  systemctl status containerd.service
   37  sudo firewall-cmd --zone=public --permanent --add-port=6443/tcp
   38  sudo firewall-cmd --zone=public --permanent --add-port=2379-2380/tcp
   39  sudo firewall-cmd --zone=public --permanent --add-port=10250/tcp
   40  sudo firewall-cmd --zone=public --permanent --add-port=10251/tcp
   41  sudo firewall-cmd --zone=public --permanent --add-port=10252/tcp
   42  sudo firewall-cmd --zone=public --permanent --add-port=10255/tcp
   43  sudo firewall-cmd --zone=public --permanent --add-port=5473/tcp
   44  sudo firewall-cmd --reload
   45  cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF

   46  dnf makecache; dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
   47  systemctl enable --now kubelet.service
   48  kubeadm join 172.20.1.1:6443 --token 96cixr.3zgsvlrx2wbswgpo --discovery-token-ca-cert-hash sha256:e4319857d3cfdd5507d10de89fa1546af4f940f9acb8b19cafd6bb0b7f8fd0e4
   49  history > worker.sh
