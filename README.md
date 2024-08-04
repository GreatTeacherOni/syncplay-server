# syncplay-server
Dockerfile for a syncplay server

![syncplay](https://raw.githubusercontent.com/Syncplay/syncplay/master/syncplay/resources/hicolor/128x128/apps/syncplay.png) 

[Syncplay](http://syncplay.pl/)  
[[Guide]Running a server](https://syncplay.pl/guide/server/)

## Usage

If you want to use TLS, you have to set the hostname of the container to a domain that is covered in your certificate

```
docker create \
--name=syncplay \
--net=host \
--hostname=syncplay.example.com
--user 1000:1000
-e PASSWORD=<PASSWORD> \
-e PORT=<PORT> \
-e TLS=/certs \
-v <certs>:/certs \
ghcr.io/florinke/syncplay-server
```

## Docker Deploy
There is a Docker deploy file available under Deployment.
Simply replace or remove the PASSWORD and you are good to go.
To deploy run
```
docker stack deploy -c docker-compose.yml syncplay
```
