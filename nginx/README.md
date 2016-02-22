# nginx

- [Simple nginx example with docker](#simple-nginx-example-with-docker)
- [WS example](#ws-example)
- [The SSL example](#the-ssl-example)
- [Use WSS with nginx](#use-wss-with-nginx)
- [Local kubernetes nginx ws](#local-kubernetes-nginx-ws)

##### Side notes before start
Every command in this tutorial is run from the root of each of the project

## Simple nginx example with docker
Prerequisites :
- you need to install [docker](https://github.com/tdeheurles/docs/blob/master/docker)


The nginx container is just 130mb, you can start pulling it with :
```bash
docker pull nginx:latest
```

Go/create the project directory and create a html index page :
```bash
echo "Hello from NginX" > index.html
```

Generate a nginx conf. We say that we want to serve on port 80 for the `/` location
```bash
cat <<EOF > site.conf
server {
  listen 80;
  location / {
    root /www;
  }
}
EOF
```

and the Dockerfile to run our website
```bash
cat <<EOF > Dockerfile
FROM        nginx:latest

RUN         rm /etc/nginx/conf.d/*.conf

WORKDIR     /usr/src

COPY        index.html   /www/
COPY        site.conf    /etc/nginx/conf.d/

ENTRYPOINT  nginx -g 'daemon off;'
EOF
```


Build the container
```bash
docker build -t my-website .
```


and run it
```bash
docker run -d -p 80:80 my-website > container_id
```


look if all is fine :
```bash
$ curl localhost
Hello from NginX
```

Then clean
```bash
$ cat container_id | xargs docker stop
9ddc387b297b
```
```bash
$ cat container_id | xargs docker rm
9ddc387b297b
```
```bash
$ docker rmi my-website
Untagged: my-website:latest
Deleted: 421067b514bf3f4b48cdb857b5115d1cb2170fd598a757f074e2ae069d0ea5bf
Deleted: 5570ce98d46297675aadbe5583a75b782e4dae45d332a20e0748df62dc86ad12
Deleted: 92f8b0503754cb577542d57d68c7be5988169ee73d5636e6cef36228c808f981
Deleted: 0acf6acd16f33ca34c8352606e668bf4cf0a340abf4502fab2a069075d27e389
Deleted: 190abb46cbc94826b6cdf587ea353bcc56851d8fca7392d2b254daa15b00d9dd
```

## WS example
### We first create a backend (go/docker)
```bash
cat <<EOF > backend.go
package main

import (
	"fmt"
	"log"
	"net/http"

	"code.google.com/p/go.net/websocket"
)

func Echo(ws *websocket.Conn) {
	var err error

	for {
		var reply string

		// reception
		if err = websocket.Message.Receive(ws, &reply); err != nil {
			fmt.Println("Can't receive")
			break
		}

		// log
		fmt.Println("Received back from client: " + reply)

		msg := "Received:  " + reply
		fmt.Println("Sending to client: " + msg)

		// respond
		if err = websocket.Message.Send(ws, msg); err != nil {
			fmt.Println("Can't send")
			break
		}
	}
}

func main() {
	fmt.Println("Running ...")

	http.Handle("/", websocket.Handler(Echo))

	if err := http.ListenAndServe(":1234", nil); err != nil {
		log.Fatal("ListenAndServe:", err)
	}
}
EOF
```
Create the Dockerfile :
```bash
cat <<EOF > backend.Dockerfile
FROM        golang:latest

COPY        backend.go   /go/src/backend/

WORKDIR     /go/src/backend/
RUN         go get code.google.com/p/go.net/websocket
RUN         go install

ENTRYPOINT  backend
EOF
```

Build and run it :
```bash
docker build --no-cache -t ws-backend -f backend.Dockerfile .
docker run \
  -d \
  -p 1234:1234 \
  backend \
  > container_backend_id
```

Control it :
```bash
curl localhost:1234
not websocket protocol%
```

### Then we create the front
```bash
cat <<EOF > index.html
<html>
<head></head>
<body>
    <script type="text/javascript">
        var sock = null;
        var wsuri = "ws://localhost:1234";

        window.onload = function() {
            sock = new WebSocket(wsuri);
            sock.onopen = function()     { alert("connected to " + wsuri); }
            sock.onclose = function(e)   { alert("connection closed (" + e.code + ")"); }
            sock.onmessage = function(e) { alert("message received: " + e.data); }
        };

        function send() {
            var msg = document.getElementById('message').value;
            sock.send(msg);
        };
    </script>
    <h1>WebSocket Echo Test</h1>
    <form>
        <p>
            Message: <input id="message" type="text" value="Hello, world!">
        </p>
    </form>
    <button onclick="send();">Send Message</button>
</body>
</html>
EOF
```

The same nginx configuration as before
```bash
cat <<EOF > site.conf
server {
  listen 80;
  location / {
    root /www;
  }
}
EOF
```

and the Dockerfile to run our website
```bash
cat <<EOF > Dockerfile
FROM        nginx:latest

RUN         rm /etc/nginx/conf.d/*.conf

WORKDIR     /usr/src

COPY        index.html   /www/
COPY        site.conf    /etc/nginx/conf.d/

ENTRYPOINT  nginx -g 'daemon off;'
EOF
```


Build and run the container
```bash
docker build -t my-ws-website . \
  && docker run -d -p 80:80 my-ws-website > container_id
```

Go to localhost in browser, you should be connected


## The SSL example
We will now create a SSL nginx

Go or create the project directory.

We need certificates. Follow [this tutorial](https://github.com/tdeheurles/docs/blob/master/certificates/create_ssl_certificates.md) to generate the key and the certificate, or you can also just run this interactive code :

```bash
openssl genrsa 1024 > ./ssl/site.key

# /!\ give `localhost` when asked for common name /!\
openssl req -new -key ./ssl/site.key > ./ssl/site.csr
```
```bash
# /!\ give a passphrase when asked for /!\
openssl genrsa -des3 1024 > ./ssl/ca.key
```
```bash
# /!\ give the passphrase you have just written when asked for /!\
# you can let the others empty
openssl req -new -x509 -days 365 -key ./ssl/ca.key > ./ssl/ca.crt
```
```bash
# /!\ give the passphrase you have just written when asked for /!\
openssl x509 -req -in ./ssl/site.csr -out ./ssl/site.crt -CA ./ssl/ca.crt -CAkey ./ssl/ca.key -CAcreateserial -CAserial ./ssl/ca.srl
```

Here is the new site.conf. We add server_name, switch ssl on, and give the
certificates we have just created
```bash
cat <<EOF > site.conf
server {
  server_name localhost;
  listen 443;

  ssl on;
  ssl_certificate        /ssl/site.crt;
  ssl_certificate_key    /ssl/site.key;

  location / {
    root /www;
  }
}
EOF
```

Html and Dockerfile are the sames as `simple example` :
```bash
echo "Hello from SSL NginX" > index.html
cat <<EOF > Dockerfile
FROM        nginx:latest

RUN         rm /etc/nginx/conf.d/*.conf

WORKDIR     /usr/src

COPY        index.html   /www/
COPY        site.conf    /etc/nginx/conf.d/

ENTRYPOINT  nginx -g 'daemon off;'
EOF
```

We should now be able to build and run :

Build the container
```bash
docker build --no-cache -t my-website .
```


and run it
```bash
docker run \
  -d \
  -v `pwd`/ssl/:/ssl/ \
  -p 443:443 \
  my-website \
  > container_id
```


look if all is fine :
```bash
curl --cacert ./ssl/ca.crt https://localhost
Hello from SSL NginX
```

Then clean
```bash
cat container_id | xargs docker stop | xargs docker rm
9ddc387b297b
```

```bash
docker rmi my-website
Untagged: my-website:latest
Deleted: 421067b514bf3f4b48cdb857b5115d1cb2170fd598a757f074e2ae069d0ea5bf
Deleted: 5570ce98d46297675aadbe5583a75b782e4dae45d332a20e0748df62dc86ad12
Deleted: 92f8b0503754cb577542d57d68c7be5988169ee73d5636e6cef36228c808f981
Deleted: 0acf6acd16f33ca34c8352606e668bf4cf0a340abf4502fab2a069075d27e389
Deleted: 190abb46cbc94826b6cdf587ea353bcc56851d8fca7392d2b254daa15b00d9dd
```

## Use WSS with nginx
`This is a work in progress, connection between front and backend via proxy is not functional`

Go to, or create, the project folder.

### Backend
Create a server to listen ws on localhost:1234 :
```bash
cat <<EOF > backend.go
package main

import (
	"fmt"
	"log"
	"net/http"

	"code.google.com/p/go.net/websocket"
)

func Echo(ws *websocket.Conn) {
	var err error

	for {
		var reply string

		// reception
		if err = websocket.Message.Receive(ws, &reply); err != nil {
			fmt.Println("Can't receive")
			break
		}

		// log
		fmt.Println("Received back from client: " + reply)

		msg := "Received:  " + reply
		fmt.Println("Sending to client: " + msg)

		// respond
		if err = websocket.Message.Send(ws, msg); err != nil {
			fmt.Println("Can't send")
			break
		}
	}
}

func main() {
	fmt.Println("Running ...")

	http.Handle("/", websocket.Handler(Echo))

	if err := http.ListenAndServe(":1234", nil); err != nil {
		log.Fatal("ListenAndServe:", err)
	}
}
EOF
```

Create the Dockerfile :
```bash
cat <<EOF > backend.Dockerfile
FROM        golang:latest

COPY        backend.go   /go/src/backend/

WORKDIR     /go/src/backend/
RUN         go get code.google.com/p/go.net/websocket
RUN         go install

ENTRYPOINT  backend
EOF
```

Build and run it :
```bash
docker build --no-cache -t backend -f backend.Dockerfile .
docker run \
  -d \
  -p 1234:1234 \
  backend \
  > container_backend_id
```

Control it :
```bash
curl localhost:1234
not websocket protocol%
```

### Front
Create your SSL certificates. Follow [here](#the-ssl-example) if needed.

The new config file is here :
```bash
cat <<EOF > site.conf
server {
  listen 443;
  server_name ws-front;

  ssl on;
  ssl_certificate        /ssl/site.crt;
  ssl_certificate_key    /ssl/site.key;

  location / {
    root /www;
  }
}
EOF
cat <<EOF > proxy.conf
server {
  listen 80;
  server_name ws-proxy;

  #ssl on;
  #ssl_certificate        /ssl/site.crt;
  #ssl_certificate_key    /ssl/site.key;

  location / {
    root /www;
    #proxy_http_version  1.1;

    #proxy_set_header    Upgrade \$http_upgrade;
    #proxy_set_header    Connection "upgrade";
    #proxy_set_header    Host \$host;
    #proxy_set_header    X-Real-IP \$remote_addr;
    #proxy_set_header    X-Forwarded-For \$proxy_add_x_forwarded_for;

    #proxy_pass          http://localhost:1234 ;
  }
}
EOF
```

We have to change the html file with javascript to connect with WSS
```bash
cat <<EOF > index.html
<html>
<head></head>
<body>
    <script type="text/javascript">
        var sock = null;
        var wsuri = "wss://localhost:4321";

        window.onload = function() {
            sock = new WebSocket(wsuri);
            sock.onopen = function()     { alert("connected to " + wsuri); }
            sock.onclose = function(e)   { alert("connection closed (" + e.code + ")"); }
            sock.onmessage = function(e) { alert("message received: " + e.data); }
        };

        function send() {
            var msg = document.getElementById('message').value;
            sock.send(msg);
        };
    </script>
    <h1>WebSocket Echo Test</h1>
    <form>
        <p>
            Message: <input id="message" type="text" value="Hello, world!">
        </p>
    </form>
    <button onclick="send();">Send Message</button>
</body>
</html>
EOF
```

The Dockerfile is still the same
```bash
cat <<EOF > front.Dockerfile
FROM        nginx:latest

RUN         rm /etc/nginx/conf.d/*.conf

WORKDIR     /usr/src

COPY        index.html   /www/
COPY        site.conf    /etc/nginx/conf.d/
COPY        proxy.conf   /etc/nginx/conf.d/

ENTRYPOINT  nginx -g 'daemon off;'
EOF
```

Build and run the container
```bash
docker build --no-cache -t my-website -f front.Dockerfile .
docker run \
  -d \
  -v `pwd`/ssl/:/ssl/ \
  -p 443:443 \
  my-website \
  > container_front_id
```


## Local kubernetes nginx ws
This is a work in Progress turorial.

Some parts of this tutorial are linked with other tutorials. Just go there and follow for more informations.

Do not hesitate to create issue for any questions or needed improvement.

Here are some of the links you can go through :
- [ws-front](https://github.com/tdeheurles/ws-front) for the front part
- [ws-backend](https://github.com/tdeheurles/ws-backend) for the backend
- [ws-wssproxy](https://github.com/tdeheurles/ws-wssproxy) for the proxy
- [my kubernetes doc](https://github.com/tdeheurles/docs/master/kubernetes) for running kubernetes locally

### ws-front
It's the address where the user will go. The code is similar to what we did before with additions for jenkins/kubernetes.

Create a new project named ws-front. (Follow the `create project part` of [this tutorial](https://github.com/tdeheurles/docs/blob/matser/jenkins-ci-k8s-cd#project-construction) for further details)

```bash
projectname=ws-front
git clone --depth=1 git://github.com/tdeheurles/k8s-base $projectname
rm -rf !$/.git
```

Go to relase.cfg and update it. `projectid` must correspond to your google cloud project.
```bash
# Service name, will be used for service DNS
servicename="ws-front"

# Manual versioning part
servicemajor=0
serviceminor=0

# Project registry to stock the container
projectid="your-project-name"

# ports
serviceportname="http"
serviceport=80

# api
k8s_api_version="v1"
template_extension="yml"
```

We now add the sources for the front, (think to give the good address to your ws-proxy) :
```bash
proxy_address=ws-proxy.tdeheurles.com
```
```bash
rm src/README.md
cat <<EOF > src/site.conf
server {
  listen 80;
  server_name ws-front;

  location / {
    root /www;
  }
}
EOF
cat <<EOF > src/index.html
<html>
<head></head>
<body>
    <script type="text/javascript">
        var sock = null;
        var wsuri = "ws://$proxy_address";

        window.onload = function() {
            sock = new WebSocket(wsuri);
            sock.onopen = function()     { alert("connected to " + wsuri); }
            sock.onclose = function(e)   { alert("connection closed (" + e.code + ")"); }
            sock.onmessage = function(e) { alert("message received: " + e.data); }
        };

        function send() {
            var msg = document.getElementById('message').value;
            sock.send(msg);
        };
    </script>
    <h1>WebSocket Echo Test</h1>
    <form>
        <p>
            Message: <input id="message" type="text" value="Hello, world!">
        </p>
    </form>
    <button onclick="send();">Send Message</button>
</body>
</html>
EOF
```

I like to add a start script too :
```bash
cat <<EOF > src/start.sh
nginx -g 'daemon off;'
EOF
```

then update the template.Dockerfile to containerise our service :
```bash
cat <<EOF > build/template.Dockerfile
FROM        nginx:latest

RUN         rm /etc/nginx/conf.d/*.conf

WORKDIR     /usr/src

COPY        index.html    /www/
COPY        start.sh      /usr/src/
COPY        site*.conf    /usr/src/

ENTRYPOINT  ./start.sh
EOF
```

In order to run build locally, add this file to the config
```bash
cat <<EOF > config/localbuild.cfg
local_build=true
EOF
```

**Our service is ready to run.**

Note that the main.sh script will build from that template, you do not have to create new file.

You can see rc and service below :
```yml
kind: ReplicationController
apiVersion: v1
metadata:
  name: __rcName__
  labels: &labels
    name: __rcName__
    major: "__major__"
    minor: "__minor__"
    build: "__build__"

spec:
  replicas: __replicas__
  selector: *labels
  template:
    metadata:
      name: __rcName__
      labels: *labels

    spec:
      containers:
        - name: __rcName__
          image: __image__
          ports:
             - name: __privatePortName__
               containerPort: __privatePort__
```

The service template should be ok, just control that LoadBalancer is activated.
```yml
kind: Service
apiVersion: v1
metadata:
  name: __serviceName__
  labels:
    name: __serviceName__
    major: "__major__"
spec:
  ports:
    -  name: __publicPortName__
       port: __publicPort__
       targetPort: __privatePortName__
       protocol: TCP
  selector:
    name: __rcName__
    major: "__major__"
    minor: "__minor__"
    build: "__build__"
  clusterIP: ''
  type: LoadBalancer
  sessionAffinity: ClientIP
```

The code should be fine now, try a build :
```bash
./build/main.sh
```

**Then we can ask kubernetes to start the rc and service.**

If you use the tdeheurles/HomeKube project, you can just :
```bash
kcreate
```

else you can :
```bash
kubectl create \
  -f ./deploy/kubernetes/v1/rc_latest.yml \
  -f ./deploy/kubernetes/v1/service_latest.yml
```

**Have a look to what is going in kubernetes :**
For HomeKube just :
```bash
kst
```
```bash
SERVICES
NAME         LABELS                                                              SELECTOR                                IP(S)           PORT(S)
kube-dns     k8s-app=kube-dns,kubernetes.io/cluster-service=true,name=kube-dns   k8s-app=kube-dns                        10.100.0.10     53/UDP
                                                                                                                                         53/TCP
kubernetes   component=apiserver,provider=kubernetes                             <none>                                  10.100.0.1      443/TCP
ws-front     major=0,name=ws-front                                               build=0,major=0,minor=0,name=ws-front   10.100.83.254   80/TCP

RC
CONTROLLER   CONTAINER(S)   IMAGE(S)                                         SELECTOR                                REPLICAS
kube-dns     etcd           gcr.io/google_containers/etcd:2.0.9              k8s-app=kube-dns                        1
             kube2sky       gcr.io/google_containers/kube2sky:1.7
             skydns         gcr.io/google_containers/skydns:2015-03-11-001
ws-front     ws-front       ws-front:localbuild.0.0.0                  build=0,major=0,minor=0,name=ws-front   1

PODS
NAME             READY     REASON    RESTARTS   AGE
kube-dns-kuhl3   3/3       Running   0          40m
ws-front-9nctw   1/1       Running   0          35m
```

Else :
```bash
kubectl get service
kubectl get rc
kubectl get pods

# You can also run
# $ kubectl get service,rc,pods
# But it's not as easy to read
```
