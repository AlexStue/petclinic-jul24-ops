# petclinic-jul24-ops
For CI/CD OPS-Path

-----------------
HowTo: 

Repo OPS: https://github.com/AlexStue/petclinic-jul24-ops.git
- open the Repo to change the Server-IP inside the "/terraform/variables.tf" file and commit+push
- a runner will be started and deploys the app on the DTS-Server
- Wait a view minutes and open in browser: http://<DTS-IP>:30002

Repo DEV: https://github.com/AlexStue/petclinic-jul24-dev.git
+ Dockerfile: Implementation done
+ Dockerimage to DockerHub: Implementation done
+ GitHub Action: Biuld and upload: Implementation and testing done.
+ Dockerhub image -> alexstue/jul24-petclinic:latest

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

2024.09.19:
- A GitHub-Action is now implemented and tested.
- If you change the IP of the DTS-Server in terraform/variables.tf and commit, the runner will be started
- The runner of “deploy-action.yml” will:
    - extract IP out of terraform/variables.tf
    - set up SSH to DTS-Server
    - copy and run the script “scripts/deploy-on-dts.sh”. The script does on the server:
        - update and install terraform
        - clone or update the OPS-repo
        - terraform apply
        - -> petclinic app is online ( at the moment via NodePort. Implementation via ingress and impl. of databases and else is pending -> under topic of terraform and k3s)