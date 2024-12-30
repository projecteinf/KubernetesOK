sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet
kubelet --version
sudo apt-mark hold kubelet 
sudo apt-mark showhold
sudo apt-get install -y kubeadm
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a
free -h
sudo modprobe br_netfilter
echo "br_netfilter" | sudo tee -a /etc/modules-load.d/k8s.conf
echo "net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1 " | sudo tee -a /etc/modules-load.d/k8s.conf

echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
sudo sysctl --system
sudo apt update sudo apt install -y containerd
sudo apt install -y containerd
CONFIG_FILE="/etc/containerd/config.toml"
if [[ -f $CONFIG_FILE ]]; then
    sudo sed -i '/plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options/,/}/ s/SystemdCgroup = false/SystemdCgroup = true/' $CONFIG_FILE;     echo "S'ha actualitzat SystemdCgroup a true al fitxer $CONFIG_FILE."; else     echo "El fitxer $CONFIG_FILE no existeix. Assegura't que containerd està configurat."; fi
echo "runtime-endpoint: unix:///run/containerd/containerd.sock" | sudo tee /etc/crictl.yaml
sudo systemctl enable containerd
sudo kubeadm join 172.20.1.1:6443 --token xotx6k.pnmgtxat94tr58l6 --discovery-token-ca-cert-hash sha256:6ccb1f977b75da38ed9633f469440d80baeeadd774fffb29e4059db0ef6dc9f5
