#!/bin/bash
set -e

# zmienne z .env
source .env

#ngrok
echo "[*] Uruchamiam ngrok..."
ngrok config add-authtoken $NGROK_AUTH_TOKEN > /dev/null 2>&1 || true
ngrok http $NGROK_PORT > ngrok.log &
sleep 5

# pobranie publicznego URL
for i in {1..15}; do
    NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -Eo 'https://[a-z0-9\.-]+' | head -n1)
    if [ ! -z "$NGROK_URL" ]; then
        break
    fi
    sleep 1
done

echo "[+] Ngrok URL: $NGROK_URL"

CONFIG_FILE=./app/jupyterhub/jupyterhub_config.py


sed -i "s|your.hostname.tld|${NGROK_URL#https://}|" docker-compose.yml

echo "* uruchamianie docker-compose..."
docker-compose down -v
docker-compose up --build
