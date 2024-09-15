# petclinic-jul24-ops
For CI/CD OPS-Path

-----------------
Protocol:
2024.09.14: 
- SSH-Key added
- folder for terraform and kubernetes added
- first aproach of a tf & k3s comination with a nginx-webserver
2024.09.15: 
- Terraform apply läuft durch
- Webserver mit individueller Seite ist nach Terraform apply unter http://<DTS-IP>:30001 erreichbar
ausstehend: 
- Wie wird Terraform gestartet? Über GitHub Actions? 
- Wie löst man das mit der privat-key-Datei für die SSH Verbindung?
