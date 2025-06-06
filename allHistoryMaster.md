```bash
    1  cd /etc/NetworkManager/system-connections/
    2  vi ens4.nmconnection 
    3  hostname
    4  shutdown now
    5  ls
    6  bash master.sh 
    7  ls
    8  cat master.sh 
    9  vi master.sh 
   10  ssh 172.20.1.30
   11  ssh 172.20.1.20
   12  clear
   13  vi master.sh 
   14  scp master.sh isard@172.20.1.100:/home/isard/master.sh
   15  clear
   16  history
   17  ip a
   18  cat master.sh 
   19  bash master.sh 
   20  kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml
   21   
   22  vi master.sh 
   23  clear
   24  cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
   25    [kubernetes]
   26    name=Kubernetes
   27    baseurl=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/
   28    enabled=1
   29    gpgcheck=1
   30    gpgkey=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/repodata/repomd.xml.key
   31    exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
   32  EOF
   33  dnf makecache; dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
   34  systemctl enable --now kubelet.service
   35  kubeadm config images pull
   36  kubeadm init --apiserver-advertise-address=172.20.1.10 --pod-network-cidr=10.244.0.0/16
   37  systemctl stop firewalld.service
   38  systemctl disable firewalld.service
   39  mkdir .kube
   40  cp -i /etc/kubernetes/super-admin.conf .kube/config
   41  kubectl get pods -n kube-system
   42  kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
   43  wget https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml
   44  sed -i 's/cidr: 192\.168\.0\.0\/16/cidr: 10.244.0.0\/16/g' custom-resources.yaml
   45  kubectl create -f custom-resources.yaml
   46  kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml
   47  kubectl get pods -n kube-system
   48  dnf makecache; dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
   49  cat /etc/yum.repos.d/kubernetes.repo 
   50  dnf update
   51  clear
   52  dnf makecache; dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
   53  dnf makecache; dnf install -y kubelet --disableexcludes=kubernetes
   54  cat /etc/yum.repos.d/kubernetes.repo 
   55  vi /etc/yum.repos.d/kubernetes.repo 
   56  vi master.sh 
   57  bash master.sh 
   58  clear
   59  cat master.sh 
   60  vi /etc/yum.repos.d/kubernetes.repo 
   61  dnf makecache; dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
   62  cat /etc/yum.repos.d/kubernetes.repo 
   63  vi master.sh 
   64  bash master.sh 
   65  rm -f /etc/yum.repos.d/kubernetes.repo
   66  vi master.sh 
   67  bash master.sh 
   68  kubectl get pods -n calico-system
   69  cat master.sh 
   70  kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml
   71  kubectl get pods -n calico-system
   72  cat master.sh 
   73  ip a | grep 172
   74  ip a
   75  vi /etc/hosts 
   76  clear
   77  ls
   78  ping workeri
   79  ping workerii
   80  cat /etc/hosts
   81  scp master.sh isard@172.20.1.10:/home/isard/
   82  scp master.sh isard@172.20.1.100:/home/isard/
   83  cd Deployment/
   84  ls
   85  cat CrearDBOdoo.sh 
   86  kubectl exec -it $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1) -- odoo -d odoo --init=base --load-language=ca
   87  ls /etc/*
   88  ls /etc/odoo*
   89  kubectl exec -it $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1) -- /bin/bash
   90  kubectl exec -it $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1) -- odoo -d odoo --init=base --load-language=ca
   91  kubectl -it $(kubectl get pods | grep odoo | cut -d' ' -f1) -- /bin/bash
   92  kubectl exec -it $(kubectl get pods | grep odoo | cut -d' ' -f1) -- /bin/bash
   93  cat master.sh | grep init
   94  kubectl get pods
   95  kubectl get pods -n kube-system
   96  kubectl get pods -n calico-system
   97  clear
   98  kubectl logst $(kubectl get pods | grep odoo | cut -d' ' -f1) 
   99  kubectl logs $(kubectl get pods | grep odoo | cut -d' ' -f1) 
  100  kubectl pods delete $(kubectl get pods | grep odoo | cut -d' ' -f1) 
  101  kubectl delete pods $(kubectl get pods | grep odoo | cut -d' ' -f1) 
  102  kubectl get pods 
  103  kubectl logs $(kubectl get pods | grep odoo | cut -d' ' -f1) 
  104  kubectl get pods 
  105  kubectl logs $(kubectl get pods | grep odoo | cut -d' ' -f1) 
  106  clear
  107  kubectl logs $(kubectl get pods | grep odoo | cut -d' ' -f1) 
  108  ping 172.20.1.10
  109  curl http://172.20.1.10:30000/
  110  systemctl status firewalld
  111  clear
  112  curl http://172.20.1.10:30000/
  113  curl http://localhost:30000/
  114  ping 172.20.1.10
  115  clear
  116  kubectl get pods
  117  kubectl get pods -n kube-system
  118  kubectl get pods -n calico-system
  119  clear
  120  curl http://172.20.1.10:30000/
  121  systemctl status firewalld
  122  kubectl logs $(kubectl get pods | grep odoo | cut -d' ' -f1) 
  123  kubectl get svc
  124  cat master.sh 
  125  kubeadm token create --print-join-command
  126  kubectl get nodes
  127  clear
  128  ls *.yaml
  129  cd Deployment/
  130  ls
  131  kubectl apply -f postgres-deployment.yaml 
  132  kubectl apply -f odoo_deployment.yaml 
  133  kubectl get pods
  134  kubectl logs $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1)
  135  clear
  136  kubectl get pods
  137  kubectl logs $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1)
  138  kubectl get pods -n kube-system
  139  kubectl get pods -n calico-system
  140  kubectl get pods 
  141  kubectl logs $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1)
  142  kubectl exec -it $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1) -- /bin/bash # psql -U odoo -d odoo -c '\dt'
  143  kubectl get svc
  144  kubectl get pdos
  145  kubectl get pods
  146  kubectl get pods -n kube-system
  147  kubectl get pods -n calico-system
  148  kubectl exec -it $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1) -- /bin/bash # psql -U odoo -d odoo -c '\dt'
  149  kubectl logs $(kubectl get pods | grep odoo | cut -d' ' -f1)
  150  kubectl delete pod $(kubectl get pods | grep odoo | cut -d' ' -f1)
  151  kubectl get pods -n calico-system
  152  kubectl get pods
  153  kubectl logs $(kubectl get pods | grep odoo | cut -d' ' -f1)
  154  cat configMap.yaml 
  155  kubectl describe svc odoo
  156  kubectl get svc
  157  echo "apiVersion: v1
  158  kind: Service
  159  metadata:
  160    name: odoo
  161  spec:
  162    selector:
  163      app: odoo
  164    ports:
  165      - protocol: TCP
  166        port: 8069
  167        targetPort: 8069
  168        nodePort: 30000
  169    type: NodePort
  170  " > odoo-service.yaml
  171  cat odoo-service.yaml 
  172  kubectl apply -f odoo-service.yaml 
  173  kubectl get svc
  174  history | grep odoo
  175  ls *.sh
  176  lsls
  177  ls
  178  cp odoo-service.yaml isard@172.20.1.100:/home/isard/
  179  scp odoo-service.yaml isard@172.20.1.100:/home/isard/
  180  kubectl exec -it $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1) -- odoo -d odoo --init=base --load-language=ca
  181  history | grep language
  182  kubectl get pods
  183  kubectl exec -it $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1) -- odoo -d odoo --init=base --load-language=ca
  184  kubectl exec -it $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1) -- /bin/bash
  185  vi configMap.yaml
  186  scp configMap.yaml  isard@172.20.1.100:/home/isard/
  187  kubectl apply -f configMap.yaml 
  188  kubectl exec -it $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1) -- /bin/bash
  189  kubectl exec -it $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1) -- odoo -d odoo --init=base --load-language=ca
  190  echo "apiVersion: v1
  191  kind: PersistentVolume
  192  metadata:
  193    name: postgres-pv
  194  spec:
  195    capacity:
  196      storage: 10Gi
  197    accessModes:
  198      - ReadWriteOnce
  199    persistentVolumeReclaimPolicy: Retain
  200    local:
  201      path: /mnt/data/postgres
  202    nodeAffinity:
  203      required:
  204        nodeSelectorTerms:
  205        - matchExpressions:
  206          - key: kubernetes.io/hostname
  207            operator: In
  208            values:
  209            - k8smaster" > PersistentVolume.yaml
  210  kubectl apply -f PersistentVolume.yaml 
  211  echo "apiVersion: v1
  212  kind: PersistentVolumeClaim
  213  metadata:
  214    name: postgres-pvc
  215  spec:
  216    accessModes:
  217      - ReadWriteOnce
  218    resources:
  219      requests:
  220        storage: 10Gi" > PersistentVolumeClaim.yaml
  221  kubectl apply -f PersistentVolumeClaim.yaml 
  222  echo "apiVersion: v1
  223  kind: PersistentVolume
  224  metadata:
  225    name: postgres-pv
  226  spec:
  227    capacity:
  228      storage: 10Gi
  229    accessModes:
  230      - ReadWriteOnce
  231    persistentVolumeReclaimPolicy: Retain
  232    local:
  233      path: /mnt/data/postgres
  234    nodeAffinity:
  235      required:
  236        nodeSelectorTerms:
  237        - matchExpressions:
  238          - key: kubernetes.io/hostname
  239            operator: In
  240            values:
  241            - k8smaster" > PersistentVolume.yaml"
  242  "
  243  ls
  244  mv PersistentVolumeClaim.yaml persistentVolumeClaim.yaml 
  245  mv PersistentVolume.yaml persistentVolume.yaml 
  246  rm 'PersistentVolume.yaml' 
  247  rm PersistentVolume.yaml 
  248  rm PersistentVolume.yaml* 
  249  clear
  250  echo "apiVersion: apps/v1
  251  kind: Deployment
  252  metadata:
  253    name: postgres
  254  spec:
  255    replicas: 1
  256    selector:
  257      matchLabels:
  258        app: postgres
  259    template:
  260      metadata:
  261        labels:
  262          app: postgres
  263      spec:
  264        containers:
  265        - name: postgres
  266          image: postgres:15
  267          ports:
  268          - containerPort: 5432
  269          env:
  270          - name: POSTGRES_DB
  271            value: odoo
  272          - name: POSTGRES_USER
  273            value: odoo
  274          - name: POSTGRES_PASSWORD
  275            value: odoo_password
  276          volumeMounts:
  277          - name: postgres-data
  278            mountPath: /var/lib/postgresql/data
  279        volumes:
  280        - name: postgres-data
  281          persistentVolumeClaim:
  282            claimName: postgres-pvc" > postgresPersistVolume.yaml
  283  kubectl apply -f postgresPersistVolume.yaml 
  284  sudo mkdir -p /mnt/data/postgres
  285  sudo chown -R 999:999 /mnt/data/postgres  # Usuari UID 999 és l'usuari de PostgreSQL per defecte al contenidor
  286  kubectl get pods
  287  kubectl delete pod postgres-84f8dcc48b-ll4v2
  288  kubectl get pods
  289  kubectl get all | grep postgres
  290  kubectl delete deployment.apps/postgres
  291  kubectl get pods
  292  kubectl apply -f postgresPersistVolume.yaml 
  293  kubectl get pods
  294  kubectl delete pod $(kubectl get pods | grep postgres | cut -d" " -f1)
  295  kubectl get pods
  296  kubectl logs $(kubectl get pods | grep postgres | cut -d" " -f1)
  297  kubectl get pods | grep postgres | cut -d" " -f1
  298  kubectl logs $(kubectl get pods | grep postgres | cut -d" " -f1)
  299  kubectl get pods
  300  kubectl describe pod postgres-7dd55b8d88-g4pbs
  301  kubectl get pvc
  302  kubectl get pv
  303  ls -ld /mnt/data/postgres/
  304  sudo ls -ld /mnt/data/postgres
  305  sudo chown -R 999:999 /mnt/data/postgres
  306  sudo ls -ld /mnt/data/postgres
  307  kubectl describe node k8smaster
  308  kubectl taint nodes k8smaster node-role.kubernetes.io/control-plane:NoSchedule-
  309  cat persistentVolume
  310  cat persistentVolume.yaml 
  311  kubectl get nodes
  312  kubectl get pv
  313  kubectl get pvc
  314  kubectl get pods
  315  kubectl exec -it $(kubectl get pods | grep odoo | cut -d " " -f1) -- /bin/bash
  316  kubectl exec -it $(kubectl get pods | grep postgres | cut -d " " -f1) -- /bin/bash
  317  kubectl exec -it $(kubectl get pods | grep odoo | cut -d " " -f1) -- /bin/bash
  318  kubectl logs $(kubectl get pods | grep odoo | cut -d " " -f1) 
  319  kubectl exec -it $(kubectl get pods | grep odoo | cut -d " " -f1) -- /bin/bash
  320  kubectl get svc
  321  kubectl logs $(kubectl get pods | grep odoo | cut -d " " -f1) 
  322  kubectl get pods
  323  kubectl delete pod $(kubectl get pods | grep odoo | cut -d " " -f1)
  324  kubectl get pods
  325  kubectl exec -it $(kubectl get pods | grep odoo | cut -d " " -f1) -- /bin/bash
  326  kubectl logs $(kubectl get pods | grep odoo | cut -d " " -f1) 
  327  kubectl get pods
  328  clear
  329  kubectl get svc
  330  kubectl get pods -n kube-system
  331  kubectl get pods -n calico-system
  332  kubectl get pods 
  333  kubectl get nodes
  334  clear
  335  kubectl run test-pod --rm -it --image=busybox -- sh
  336  clear
  337  kubectl get svc
  338  kubectl exec -it $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1) -- /bin/bash # psql -U odoo -d odoo -c '\dt'
  339  vi configMap.yaml 
  340  kubectl apply -f configMap.yaml 
  341  kubectl get pods
  342  grep -r Deployment *.yaml
  343  cat postgresPersistVolume.yaml 
  344  ls *.yaml -l
  345  echo "apiVersion: apps/v1
  346  kind: Deployment
  347  metadata:
  348    name: odoo
  349  spec:
  350    replicas: 1
  351    selector:
  352      matchLabels:
  353        app: odoo
  354    template:
  355      metadata:
  356        labels:
  357          app: odoo
  358      spec:
  359        containers:
  360        - name: odoo
  361          image: odoo:16
  362          volumeMounts:
  363          - name: config-volume
  364            mountPath: /etc/odoo/odoo.conf
  365            subPath: odoo.conf
  366        volumes:
  367        - name: config-volume
  368          configMap:
  369            name: odoo-config" > odoo_deployment.yaml
  370  kubectl appy -f odoo_deployment.yaml 
  371  kubectl apply -f odoo_deployment.yaml 
  372  kubectl delete pod $(kubectl get pods | grep odoo | awk '{print $1}')
  373  kubectl get pods
  374  kubectl exec -it  $(kubectl get pods | grep odoo | awk '{print $1}') -- /bin/bash
  375  history | grep language
  376  kubectl exec -it $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1) -- odoo -d odoo --init=base --load-language=ca
  377  kubectl get pods
  378  kubectl exec -it  $(kubectl get pods | grep odoo | awk '{print $1}') -- /bin/bash
  379  vi configMap.yaml 
  380  cat odoo_deployment.yaml 
  381  vi odoo_deployment.yaml 
  382  kubectl apply -f odoo_deployment.yaml 
  383  kubectl get pods
  384  kubectl logs odoo-66958658d9-fp4wg 
  385  clear
  386  ls -l *.yaml
  387  cat odoo_deployment.yaml 
  388  vi odoo_deployment.yaml 
  389  kubectl apply -f odoo_deployment.yaml
  390  kubectl get pods
  391  kubectl delete pod $(kubectl get pods | grep odoo | awk '{print $1}')
  392  kubectl get pods
  393  kubectl logs $(kubectl get pods | grep odoo | awk '{print $1}')
  394  vi odoo_deployment.yaml 
  395  cat odoo_deployment.yaml 
  396  kubectl apply -f odoo_deployment.yaml
  397  kubectl get pods
  398  kubectl logs $(kubectl get pods | grep odoo | awk '{print $1}')
  399  kubectl describe deployment odoo
  400  vi odoo_deployment.yaml 
  401  ls *.yaml
  402  cat persistentVolume.yaml 
  403  grep -r addon *.yaml
  404  vi configMap.yaml 
  405  kubectl exec -it $(kubectl get pods | grep odoo | awk '{print $1}') -- ls -l /var/lib/odoo/addons/16.0
  406  kubectl logs $(kubectl get pods | grep odoo | awk '{print $1}')
  407  kubectl exec -it $(kubectl get pods | grep odoo | awk '{print $1}') -- odoo --update=all
  408  ls
  409  ssh 172.20.1.20
  410  ssh 172.20.1.30
  411  shutdown -r now
  412  kubectl get pods
  413  ls
  414  vi odoo_deployment.yaml 
  415  vi configMap.yaml 
  416  kubectl apply -f configMap.yaml 
  417  kubectl delete pod $(kubectl get pods | grep odoo | awk '{print $1}') 
  418  kubectl get pods
  419  vi odoo-service.yaml 
  420  grep -r volume *.yaml
  421  vi odoo_deployment.yaml 
  422  cat configMap.yaml 
  423  cat persistentVolume.yaml 
  424  cat persistentVolumeClaim.yaml 
  425  grep -r addon *
  426  kubectl get pods
  427  kubectl get pods -n kube-system
  428  kubectl get pods -n calico-system
  429  clear
  430  history > allHistory.txt
```
