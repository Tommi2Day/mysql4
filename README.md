# mysql4

## A Mysql4 installation running on Docker
In 2015 when Mysql 5.7 ist current, a MySQL4 environment is still needed as requirement from mature programs (CAO-Faktura, ...)

### build
```sh
docker build -t tommi2day/mysql4 .
```
### exposed Ports
```sh
# mysql  
EXPOSE 3306
```
### Volumes
```sh
VOLUME /db # mysql datadir
```

### Environment variables used
```sh
MYSQL_ROOT_PASSWORD	mysql4
TZ	Europe/Berlin
```
Root password will be bound to the wildcard % host to allow login from any network host.

### Run
Specify the MYSQL_ROOT_PASSWORD environment variable and a volume 
for the datafiles when launching a new container, e.g:

```sh
docker run --name mysql4 \
--add-host="mysql4:127.0.0.1" \
-e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \ 
-v /volume1/docker/mysql:/db \ 
-p 33306:3306 \
tommi2day/mysql4
```
see run.sh for an example