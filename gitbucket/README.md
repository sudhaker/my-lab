##GitBucket - Simple Install

### Launch container

```
docker run -d --restart=unless-stopped --name=my-gitbucket \
-p 8080:8080 \
-v /var/gitbucket:/gitbucket \
-e JAVA_OPTS="-Djava.awt.headless=true" \
f99aq8ove/gitbucket
```

URL: `http://IP_ADDR:8080/`

##GitBucket - Dedicated IP install

### Create network (if needed)

Requirement: Docker 1.12.0+

```
docker network create -d macvlan -o parent=enp4s0 \
--subnet=192.168.20.0/24 \
--gateway=192.168.20.1 \
local
```

### Launch container

```
docker run -d --restart=unless-stopped --name=my-gitbucket \
--net=local --ip=192.168.20.222 \
-v /var/gitbucket:/gitbucket \
-e JAVA_OPTS="-Djava.awt.headless=true" \
-e GITBUCKET_OPTS="--port=80" 
f99aq8ove/gitbucket
```

URL (gitbucket): `http://192.168.20.222/`
