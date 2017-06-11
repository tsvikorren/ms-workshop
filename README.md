# Conatiner Camp - Security

Extentend container camp in partnership with Aqua Security

# Prerequisites
A linux server with Docker (e.g., Ubuntu 16.04 with Azure Docker Extension)

Incoming HTTP allowed

# Instructions
* Create a Linux server and install Docker
* Close this Git repository
* Make sure all the .sh scripts are executable (chmod +x *.sh)
* run pull-images.sh
* run install-aqua.sh
* Browse to the host's external address on port 80

Images:
* containercamp.azurecr.io/aquasec/server:2.1.5
* containercamp.azurecr.io/aquasec/gateway:2.1.5
* containercamp.azurecr.io/aquasec/agent:2.1.5
* containercamp.azurecr.io/aquasec/scanner-cli:2.1.5
* postgres:9.6.1-alpine
