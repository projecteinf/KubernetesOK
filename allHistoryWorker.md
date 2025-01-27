```bash
    1  vi /etc/NetworkManager/system-connections/ens4.nmconnection 
    2  hostname set-hostname workerii
    3  hostnamectl set-hostname workerii
    4  shutdown now
    5  vi /etc/hosts 
    6  exit
    7  shutdown now
    8  cat /etc/hosts
    9  vi worker.sh 
   10  bash worker.sh 
   11  kubeadm join 172.20.1.10:6443 --token 51hjdp.423kerqrl3yj8m6f --discovery-token-ca-cert-hash sha256:f68548e524734b105198b09da5ca995e58a1c4dd3bc23e78c02972848e3bc784
   12  exit
   13  shutdown -r now
   14  history
   15  exit
   16  history > allHistoryWorker.md
```
