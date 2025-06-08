#!/bin/bash
set -e

# Załaduj zmienne z .env
source .env

# Uruchom ngrok
echo "[*] Uruchamiam ngrok..."
ngrok config add-authtoken $NGROK_AUTH_TOKEN > /dev/null 2>&1 || true
ngrok http $NGROK_PORT > ngrok.log &
sleep 5

# Pobierz publiczny URL
for i in {1..15}; do
    NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -Eo 'https://[a-z0-9\.-]+' | head -n1)
    if [ ! -z "$NGROK_URL" ]; then
        break
    fi
    sleep 1
done

echo "[+] Ngrok URL: $NGROK_URL"

# Podmień w jupyterhub_config.py adres dla CAS i hosta (jeśli używasz zmiennej HOST)
CONFIG_FILE=./app/jupyterhub/jupyterhub_config.py

if grep -q "cas_server_url" $CONFIG_FILE; then
    echo "[*] Zakładam, że CAS już skonfigurowany"
else
    echo "[!] Brakuje konfiguracji CAS — dodaj ręcznie casauthenticator w jupyterhub_config.py"
fi

# (Opcjonalnie) Zmień reguły traefika, jeśli były
sed -i "s|your.hostname.tld|${NGROK_URL#https://}|" docker-compose.yml

# Uruchom JupyterHuba
echo "[*] Odpalam docker-compose..."
docker-compose down -v
docker-compose up --build
