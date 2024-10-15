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

2024.09.29
- NodePort now changed to LoadBalancer with replicas:2
- webserver still accesible under http://<DTS-IP>:30001 erreichbar
- trying let's encrypt, not running jet

2024.10.07
- terraform:
  - updated main.tf
- scripts:
  - updated install k3s + deploy k3s files
- k3s:
  - added ingress-traefik.yml
  - added tls-secret.yml
- minikube:
  - tried and added with ingress-nginx but back to k3s!!
  - deleted in commits again since we dont use it anymore

2024.10.07
- back to old structure/last commit from alexstue but added loadbalancer and ingress:
- k3s:
  - added a traefik-ingress.yml
  - petclinic service as loadbalancer running on: 
    - http://petclinic.ph-rustingheart.dns-dynamic.net:30001 with port 8080:30001/TCP
    - http://52.16.155.59:30001 with port 8080:30001/TCP
- trying tls now 

2024.10.10
- you can reach ingress-traefik/tls as loadbalancer on:
  - https://petclinic.ph-rustingheart.dns-dynamic.net/ with port 443:30345/TCP
- database mysql
  - still shows: Bad Gateway but running as a service already/ is deployed




running it on server i still sometimes have errors: 
lockfile errors:
-- sudo rm /var/lib/apt/lists/lock
-- sudo rm /var/cache/apt/archives/lock
-- sudo rm /var/lib/dpkg/lock-frontend
-- sudo apt autoremove
-- sudo dpkg --configure -a
-- sudo apt update

.ssh key errors:

-- sudo nano ~/.ssh/known_hosts + known_hosts.old 
delete:
-- crtl +k # as much as needed 
-- crtl + x
-- y
-- ...



