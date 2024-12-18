# Verficiació desactivació memòria swap
```bash
free -h
```
## Sortida (partició swap activa)
```
               total        used        free      shared  buff/cache   available
Mem:           5,8Gi       1,6Gi       3,7Gi        25Mi       731Mi       4,2Gi
Swap:          974Mi          0B       974Mi
```
## Desactivar swap

```bash
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a
```

## Sortida (partició swap desactivada)
               total        used        free      shared  buff/cache   available
Mem:           5,8Gi       1,6Gi       3,7Gi        25Mi       741Mi       4,2Gi
Swap:             0B          0B          0B
