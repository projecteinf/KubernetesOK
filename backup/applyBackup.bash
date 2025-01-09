#!/bin/bash
# Restaurar recursos
kubectl apply -f cluster-backup.yaml
# Restaurar ConfigMaps, CRDs o secrets
kubectl apply -f crds-backup.yaml
kubectl apply -f calico-configmap-backup.yaml
kubectl apply -f secrets-backup.yaml

