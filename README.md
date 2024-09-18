# petclinic-jul24-ops
For CI/CD OPS-Path

-----------------
HowTo:

# Update DTS-Server-IP
open the Repo to change the Server-IP inside the "/terraform/variables.tf" file and push/pull/OrWhatever
# install terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com focal main"
sudo apt-get update
sudo apt-get install terraform
# clone git ops-repo
git clone https://github.com/AlexStue/petclinic-jul24-ops.git
# start terraform & k3s & petclinic-app
cd /home/ubuntu/petclinic-jul24-ops/terraform
terraform init
terraform plan
terraform apply -auto-approve
# wait a view minutes and open in browser: http://<DTS-IP>:30002

-----------------
Status:

Repo DEV: https://github.com/AlexStue/petclinic-jul24-dev.git
- App: Petclinic -> .jar File
+ Dockerfile needed: Implementation done
+ Dockerimage to DockerHub: Implementation done
+ Dockerhub image -> to OPS-Path done: alexstue/jul24-petclinic:latest

+ GitHub Action: First Draft available but not testet. DRAFT.

Repo OPS: https://github.com/AlexStue/petclinic-jul24-ops.git
- hi
+ hi

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
- Wie wird Terraform gestartet? Über GitHub Actions? -> Yes inside GitHubActions
- Wie löst man das mit der privat-key-Datei für die SSH Verbindung? -> Secret in GitHub

2024.09.15: 
- Petclinic-app-image in DEV-Repo erstellt und image auf DockerHub gepushed
- Petclinic-app plus nginx Server via NodePort. Nginx is to test variables and changes with custom html-page.