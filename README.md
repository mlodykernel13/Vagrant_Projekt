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

## Konfiguracja ngroka
```bash
sudo snap install ngrok
```
Potrzebny jest token od ngrok, który można uzyskac rejestrując się/logując na https://ngrok.com
Token znajdzuje się pod zakładką dashboard https://dashboard.ngrok.com/get-started/your-authtoken

Dodanie tokenu
```bash
ngrok config add-authtoken <TOKEN>
```
Zbudowanie kontenerów

```bash
cd /vagrant/jupyterhub-docker-master
docker-compose up -d
```

Uruchomienie ngroka
```bash
ngrok http 8000
```
## Usługa znajduje się pod wygenerowanym przez ngroka linkiem (np. https://xxxxxxxxxxxxxxx.ngrok-free.app)
