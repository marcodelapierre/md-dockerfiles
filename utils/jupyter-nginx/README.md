# jupyter-nginx

This is a simple example of how to set up a containerised Jupyter Notebook server, running behind an Nginx reverse proxy, and being served
via HTTPS using free [Let’s Encrypt](https://letsencrypt.org) certificates.  The Nginx containers are the work of https://github.com/gilyes/docker-nginx-letsencrypt-sample,
and more examples of how to add your own websites can be found there.

This example is directly derived from Brian Skjerven's one for an [RStudio server](https://github.com/PawseySC/rstudio-nginx).

While this container setup can be run anywhere, this guide is primarily for users who wish to set up a Jupyter Notebook  server on Pawsey's cloud service, [Nimbus](https://www.pawsey.org.au/our-services/data/cloud-services/).

## Setup

To begin you'll need the following installed on your Nimbus VM:

* [docker](https://docs.docker.com/engine/installation/) (>= 1.10)
* [docker-compose](https://github.com/docker/compose/releases) (>= 1.8.1)

There are several ways to install Docker, and I recommend you use the official version from Docker, as the version available through most package managers (e.g. yum, apt, etc.) is outdated.  Detailed instructions can be found [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/).

You'll also need a domain (or subdomain) name for your Nimbus VM; you can create a free one using something like [No-IP](www.noip.com).

## Quick Start

More detail about each part is given below, but for those who just want to get up and running, here's what you need to do:

* Clone this [repository](https://github.com/marcodelapierre/md-dockerfiles)
* Enter directory `jupyter-nginx`
* Edit `docker-compose.yml`
	* Change `VIRTUAL_HOST` and `LETSENCRYPT_HOST` to your domain name
	* Change `LETSENCRYPT_EMAIL` to your preferred email address (it will be associated with the generated certificates)
	* If you want to mount any directories into your Jupyter Notebook container you need to change the `VOLUMES TO BE MOUNTED` line in the `jupyter` section.  An example is given in the `docker-compose.yml` file, where the directory `jupyter_data` is mounted to `/home/jovyan/work` in the cointainer
* Run `docker-compose up -d` to start the containers

You should now have a working Jupyter Notebook server that you can access via a web browser at *https://mydomain.com*.
 

## How it Works

There are 4 containers that will be used:

* Nginx reverse proxy container
* Nginx configuration container
* Let's Encrypt certificate container
* Jupyter Notebook container 

These 4 containers work together to setup the HTTPS certificates, create and configure an Nginx server, and launch a Jupyter Notebook server.  While it's possible to manually configure and start each container, it's much easier to use [docker-compose](https://github.com/docker/compose) to handle all of this for us.  At the end of this, all we'll need to do is run 

`docker-compose up -d`

and have a fully functional, containerised Jupyter Notebook server running behind Nginx with HTTPS certificates. 

You will need to run `docker-compose logs`, grab the token from the output, and use it to login through the Web browser.

To exit the container, run `docker-compose down`.

Note that the `-d` flag means our containers will run in *detached mode* (in the background).  If you find your containers aren't working or you can't access Jupyter Notebook, run `docker-compose logs` to see debug output, or re-run `docker-compose` without the `-d`.

### Nginx reverse proxy container

We'd like to add some extra security to our Jupyter Notebook server, as it's outside of Pawsey firewalls and visible to the entire internet.  We could try and configure Jupyter Notebook's web server, but it's easier (and more secure) to use an existing web server...in our case, [Nginx](www.nginx.com).

We'll be using Nginx as a reverse proxy, meaning that all web traffic that would normally go to our Jupyter Notebook server, will instead be handled by Nginx.  Jupyter Notebook server normally runs on port 8888, and instead of opening up that port to the internet (and possibly exposing a vulnerability), we can simply open a single port for Nginx, and let Nginx route traffic to our internal services (like Jupyter Notebook).

In this example, we'll be using Nginx's [Docker image](https://hub.docker.com/_/nginx/), and this will be the only externally visible container.  The **nginx** block in `docker-compose.yml` defines how this container will be configured:

```
services:
  nginx:
    restart: always
    image: nginx
    container_name: nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - "/etc/nginx/conf.d"
      - "/etc/nginx/vhost.d"
      - "/usr/share/nginx/html"
      - "./volumes/proxy/certs:/etc/nginx/certs:ro"
```
We're exposing two ports, 80 (HTTP) and 443 (HTTPS), and we are also mounting several volumes into the container:

* Configuration folder: another container will generate the Nginx config, which will define how our Nginx reverse proxy server works
* Nginx root folder: used by the Let's Encrypt container as part of the certification process
* Certificate folder: A Let's Encrypt container will produce our HTTPS certifcates and store them here

### Nginx configuration container

This container handles setting up the configuration file for our main Nginx container.  We're using the [jwilder/docker-gen](https://hub.docker.com/r/jwilder/docker-gen) image for this.  The relevant section in `docker-compose.yml` is:

```
nginx-gen:
    restart: always
    image: jwilder/docker-gen
    container_name: nginx-gen
    volumes:
      - "/var/run/docker.sock:/tmp/docker.sock:ro"
      - "./volumes/proxy/templates/nginx.tmpl:/etc/docker-gen/templates/nginx.tmpl:ro"
    volumes_from:
      - nginx
    entrypoint: /usr/local/bin/docker-gen -notify-sighup nginx -watch -wait 5s:30s /etc/docker-gen/templates/nginx.tmpl /etc/nginx/conf.d/default.conf
```

The Nginx template file (`ngninx.tmpl`) is mounted into this container, to it can be read (note the read-only flag).  We also mount `/var/run/docker.sock` into the container.  This allows the container to use Docker to inspect other containers.

### Let's Encrypt container

This container handles generating the TLS certificates we're going to use with our Jupyter Notebook server.  We're using the [jrcs/letsencrypt-nginx-proxy-companion](https://hub.docker.com/r/jrcs/letsencrypt-nginx-proxy-companion/) image.

```
letsencrypt-nginx-proxy-companion:
    restart: always
    image: jrcs/letsencrypt-nginx-proxy-companion
    container_name: letsencrypt-nginx-proxy-companion
    volumes_from:
      - nginx
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock:ro"
      - "./volumes/proxy/certs:/etc/nginx/certs:rw"
    environment:
      - NGINX_DOCKER_GEN_CONTAINER=nginx-gen
```

Just like the Nginx configuration container, we again mount in the Docker socket to give the container access to Docker.  We also mount in a `certs` directory that will hold the generated certificates.  Both of these are shared with the main Nginx container.

Also, this container will handle auto-renewing the certificates

### Jupyter Notebook container

This container sets up our Jupyter Notebook server.  In this case, we're using the latest version of the [scipy-notebook](https://hub.docker.com/r/jupyter/scipy-notebook/) image, but you can change this to a preferred version, see [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html).

This section of `docker-compose.yml` will require some modification by the user:

```
  jupyter:
    restart: always
    image: jupyter/scipy-notebook:latest
    container_name: jupyter
    volumes:
      - <VOLUMES TO BE MOUNTED>
      - "$HOME/jupyter_data:/home/jovyan/work"
    expose:
      - "8888"
    environment:
      - VIRTUAL_HOST=<YOUR HOSTNAME>
      - VIRTUAL_NETWORK=nginx-proxy
      - VIRTUAL_PORT=80
      - LETSENCRYPT_HOST=<YOUR HOSTNAME>
      - LETSENCRYPT_EMAIL=<YOUR EMAIL ADDRESS>
```
The key options to change include

* `VIRTUAL_HOST` and `LETSENCRYPT_HOST` to your domain name
* `LETSENCRYPT_EMAIL` to your preferred email address (it will be associated with the generated certificates)
* Additional volumes you want to mount into the container

In this example we've created a directory on the host in `$HOME/jupyter_data` which is then mounted into the container at `/home/jovyan/work`.

Note that this Jupyter [Jupyter Docker Stocks](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html) offers containers for other type of Notebooks, including R, Tensorflow, Spark and others.
