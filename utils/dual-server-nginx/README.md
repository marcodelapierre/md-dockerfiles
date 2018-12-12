# dual-server-nginx

This is a sample case for setting up two containerised Web servers at once, running behind an Nginx reverse proxy, and being served
via HTTPS using free [Let’s Encrypt](https://letsencrypt.org) certificates.  The Nginx containers are the work of https://github.com/gilyes/docker-nginx-letsencrypt-sample,
and more examples of how to add your own websites can be found there.

The two Web servers used as an example are:

- [Jupyter Notebook server](https://github.com/marcodelapierre/md-dockerfiles/tree/master/utils/jupyter-nginx)
- [RStudio server](https://github.com/PawseySC/rstudio-nginx)

Please refer to the READMEs of these two repos for details on the setup.
