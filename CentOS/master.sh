    1  clear
    2  ip a
    3  vi /etc/hosts 
    4  ping master
    5  clear
    6  hostname
    7  vi /etc/hosts
    8  ping `hostname`
    9  clear
   10  dnf install kernel-devel-$(uname -r)
   11  sudo modprobe br_netfilter
   12  sudo modprobe ip_vs
   13  sudo modprobe ip_vs_rr
   14  sudo modprobe ip_vs_wrr
   15  sudo modprobe ip_vs_sh
   16  sudo modprobe overlay
   17  cat > /etc/modules-load.d/kubernetes.conf << EOF
   18  br_netfilter
   19  ip_vs
   20  ip_vs_rr
   21  ip_vs_wrr
   22  ip_vs_sh
   23  overlay
   24  EOF
   25  cat > /etc/sysctl.d/kubernetes.conf << EOF
   26  net.ipv4.ip_forward = 1
   27  net.bridge.bridge-nf-call-ip6tables = 1
   28  net.bridge.bridge-nf-call-iptables = 1
   29  EOF
   30  sysctl --system
   31  Disable the swap
   32  sudo swapoff -a
   33  sed -e '/swap/s/^/#/g' -i /etc/fstab
   34  sudo swapoff -a
   35  sed -e '/swap/s/^/#/g' -i /etc/fstab
   36  add docker repo 
   37  sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
   38  sudo dnf makecache
   39   dnf -y install containerd.io
   40  sudo sh -c "containerd config default > /etc/containerd/config.toml" ; cat /etc/containerd/config.toml
   41  vim /etc/containerd/config.toml
   42  systemctl enable --now containerd.service
   43  systemctl status containerd.service
   44  sudo firewall-cmd --zone=public --permanent --add-port=6443/tcp
   45  sudo firewall-cmd --zone=public --permanent --add-port=2379-2380/tcp
   46  sudo firewall-cmd --zone=public --permanent --add-port=10250/tcp
   47  sudo firewall-cmd --zone=public --permanent --add-port=10251/tcp
   48  sudo firewall-cmd --zone=public --permanent --add-port=10252/tcp
   49  sudo firewall-cmd --zone=public --permanent --add-port=10255/tcp
   50  sudo firewall-cmd --zone=public --permanent --add-port=5473/tcp
   51  sudo firewall-cmd --reload
   52  cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
   53  [kubernetes]
   54  name=Kubernetes
   55  baseurl=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/
   56  enabled=1
   57  gpgcheck=1
   58  gpgkey=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/repodata/repomd.xml.key
   59  exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
   60  EOF
   61  dnf makecache; dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
   62  systemctl enable --now kubelet.service
   63  sudo kubeadm config images pull
   64  kubeadm init --apiserver-advertise-address=172.20.1.1 --pod-network-cidr=10.244.0.0/16
   65  systemctl stop firewalld.service 
   66  systemctl disbale firewalld.service
   67  man systemctl
   68  systemctl disbale firewalld
   69  man systemctl
   70  systemctl disable firewalld
   71  clear
   72  mkdir .kube
   73  cp -i /etc/kubernetes/super-admin.conf .kube/config
   74  kubectl get pods -n kube-system
   75  kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
   76  wget https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml
   77  sed -i 's/cidr: 192\.168\.0\.0\/16/cidr: 10.244.0.0\/16/g' custom-resources.yaml
   78  kubectl create -f custom-resources.yaml
   79  kubectl get pods -n kube-system
   80  history
   81  kubeadm token create --print-join-command
   82  shutdown now
   83  kubeadm token create --print-join-command
   84  kubectl get nodes
   85  kubectl get pods -n kube-system
   86  kubectl get nodes
   87  kubectl get pods -n kube-system
   88  history
   89  ip a
   90  history > master.sh
