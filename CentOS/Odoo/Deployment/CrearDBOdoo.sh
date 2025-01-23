kubectl exec -it $(kubectl get pods | head -n2 | tail -n1 | cut -d' ' -f1) -- odoo -d odoo --init=base --load-language=ca
