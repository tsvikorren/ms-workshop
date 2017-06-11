HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
AQUA_LICENSE=$(cat ./aqua-license)

docker run -d -p 5432:5432 --name aqua-db --restart=always \
  -e POSTGRES_PASSWORD=zIw6oxC5B5 \
  postgres:9.6.1-alpine

docker run -d -p 8080:8080 -p 80:8080 --restart=always --name aqua-web --user=root \
   -e SCALOCK_DBUSER=postgres \
   -e SCALOCK_DBPASSWORD=zIw6oxC5B5 \
   -e SCALOCK_DBNAME=scalock \
   -e SCALOCK_DBHOST=${HOST_IP} \
   -e SCALOCK_AUDIT_DBUSER=postgres \
   -e SCALOCK_AUDIT_DBPASSWORD=zIw6oxC5B5 \
   -e SCALOCK_AUDIT_DBNAME=slk_audit \
   -e SCALOCK_AUDIT_DBHOST=${HOST_IP} \
   -e LICENSE_TOKEN=${AQUA_LICENSE} \
   -v /var/run/docker.sock:/var/run/docker.sock \
   containercamp.azurecr.io/aquasec/server:2.1.5

docker pull aquasec/gateway:$1
docker run -d -p 3622:3622 --restart=always --name aqua-gateway \
    -e SCALOCK_DBUSER=postgres \
    -e SCALOCK_DBPASSWORD=zIw6oxC5B5 \
    -e SCALOCK_DBNAME=scalock \
    -e SCALOCK_DBHOST=${HOST_IP} \
    -e SCALOCK_AUDIT_DBUSER=postgres \
    -e SCALOCK_AUDIT_DBPASSWORD=zIw6oxC5B5 \
    -e SCALOCK_AUDIT_DBNAME=slk_audit \
    -e SCALOCK_AUDIT_DBHOST=${HOST_IP} \
    -e SCALOCK_GATEWAY_PUBLIC_IP=${HOST_IP} \
    -e SCALOCK_GATEWAY_NAME=local \
    containercamp.azurecr.io/aquasec/gateway:2.1.5
