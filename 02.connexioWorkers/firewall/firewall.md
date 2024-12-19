# Firewall instal·lats
## Firewall ufw
```bash
sudo ufw status
```
## Resultat - no instal·lat
```
sudo: ufw: no s'ha trobat l'ordre
```
## Firewall firewalld
```bash
sudo systemctl status firewalld
```
## Resultat - no instal·lat
```
Unit firewalld.service could not be found.
```
## Comprovació regles iptables
```bash
sudo iptables -L -n
```
## Resultat - no instal·lat
```
sudo: iptables: no s'ha trobat l'ordre
```
