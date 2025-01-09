#!/bin/bash

# Configuració inicial
BACKUP_DIR="k8s-backup-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "Directori de còpia de seguretat: $BACKUP_DIR"

# 1. Còpia de seguretat de tots els recursos del cluster
echo "Exportant tots els recursos del cluster..."
kubectl get all --all-namespaces -o yaml > "$BACKUP_DIR/cluster-backup.yaml"

# 2. Còpia de seguretat dels recursos del namespace kube-system
echo "Exportant recursos del namespace kube-system..."
kubectl get all -n kube-system -o yaml > "$BACKUP_DIR/kube-system-backup.yaml"

# 3. Còpia de seguretat dels fitxers de configuració de kubeadm
echo "Còpia de seguretat del fitxer de configuració de kubeadm..."
sudo tar -czvf "$BACKUP_DIR/kubeadm-config-backup.tar.gz" /etc/kubernetes

# 4. Còpia de seguretat de la configuració de kubelet
echo "Còpia de seguretat de la configuració de kubelet..."
sudo tar -czvf "$BACKUP_DIR/kubelet-config-backup.tar.gz" /var/lib/kubelet

# 5. Còpia de seguretat dels CRDs
echo "Exportant Custom Resource Definitions (CRDs)..."
kubectl get crd -o yaml > "$BACKUP_DIR/crds-backup.yaml"

# 6. Còpia de seguretat dels ConfigMaps de Calico
echo "Exportant ConfigMaps de Calico..."
kubectl get configmap -n kube-system -o yaml > "$BACKUP_DIR/calico-configmap-backup.yaml"

# 7. Còpia de seguretat dels secrets
echo "Exportant secrets..."
kubectl get secrets --all-namespaces -o yaml > "$BACKUP_DIR/secrets-backup.yaml"

# 8. Còpia de seguretat dels manifestos estàtics
echo "Còpia de seguretat dels manifestos estàtics..."
sudo tar -czvf "$BACKUP_DIR/manifests-backup.tar.gz" /etc/kubernetes/manifests

# 9. Còpia de seguretat del kubeconfig
echo "Còpia de seguretat del kubeconfig..."
cp "$HOME/.kube/config" "$BACKUP_DIR/kubeconfig-backup.yaml"

# 10. Còpia de seguretat de la configuració actual de kubeadm
echo "Exportant configuració actual de kubeadm..."
sudo kubeadm config view > "$BACKUP_DIR/kubeadm-current-config.yaml"

# 11. Comprimir totes les còpies de seguretat
echo "Comprimint totes les còpies de seguretat en un únic fitxer..."
tar -czvf "$BACKUP_DIR.tar.gz" "$BACKUP_DIR"

# 12. Informació final
echo "Còpia de seguretat completada."
echo "Les còpies de seguretat s'han desat al fitxer: $BACKUP_DIR.tar.gz"

