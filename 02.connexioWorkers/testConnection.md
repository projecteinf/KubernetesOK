# Verficiació connexió master amb workers
```bash
cat /etc/network/interfaces
```
## Configuració master
```
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

auto enp1s0
iface enp1s0 inet dhcp

auto enp2s0
iface enp2s0 inet static
	address 172.20.1.1
	netmask 255.255.0.0
``` 
## Configuració worker I
```
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

auto enp1s0
iface enp1s0 inet dhcp

auto enp2s0
iface enp2s0 inet static
	address 172.20.1.2
	netmask 255.255.0.0
``` 
## Configuració worker II
```
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

auto enp1s0
iface enp1s0 inet dhcp

auto enp2s0
iface enp2s0 inet static
	address 172.20.1.3
	netmask 255.255.0.0
``` 

## Test connexió (des del master)
```bash
ping 172.20.1.2
ping 172.20.1.3
```
## Resultat test connexió worker I
```
PING 172.20.1.2 (172.20.1.2) 56(84) bytes of data.
64 bytes from 172.20.1.2: icmp_seq=1 ttl=64 time=4.74 ms
64 bytes from 172.20.1.2: icmp_seq=2 ttl=64 time=2.37 ms
64 bytes from 172.20.1.2: icmp_seq=3 ttl=64 time=2.27 ms

--- 172.20.1.2 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2004ms
rtt min/avg/max/mdev = 2.271/3.124/4.737/1.140 ms
```
## Resultat test connexió worker II
```
PING 172.20.1.3 (172.20.1.3) 56(84) bytes of data.
64 bytes from 172.20.1.3: icmp_seq=1 ttl=64 time=15.1 ms
64 bytes from 172.20.1.3: icmp_seq=2 ttl=64 time=2.16 ms
64 bytes from 172.20.1.3: icmp_seq=3 ttl=64 time=2.56 ms
64 bytes from 172.20.1.3: icmp_seq=4 ttl=64 time=2.43 ms

--- 172.20.1.3 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3005ms
rtt min/avg/max/mdev = 2.162/5.566/15.114/5.514 ms
