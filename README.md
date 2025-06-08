# JupyterHub na Vagrant z Dockerem

## Wymagane programy

- VirtualBox
- Vagrant

## Uruchomienie
W folderze z plikamy otwieramy terminal
```bash
vagrant up
```
Po uruchomieniu maszyny
```bash
vagrant ssh
```
Po połączeniu się z maszyną
```bash
cd /vagrant/jupyterhub-docker-master
docker-compose up -d
```
