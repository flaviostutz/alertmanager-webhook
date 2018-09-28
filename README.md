# alertmanager-webhook
Prometheus Alertmanager that will send alert notifications to a webhook configured by ENVs

# Usage

docker-compose.yml:
```
version: '3.3'

services:

  alertmanager:
    build: .
    ports:
      - 9093:9093
    environment:
      - WEBHOOK_URL=http://telegrambot:8080
    volumes:
      - alertmanager:/alertmanager

  telegrambot:
    image: metalmatze/alertmanager-bot:0.3.1
    environment:
      - ALERTMANAGER_URL=http://alertmanager:9093
      - BOLT_PATH=/data/bot.db
      - STORE=bolt
      - LISTEN_ADDR=0.0.0.0:8080
      - TELEGRAM_ADMIN=AAAA
      - TELEGRAM_TOKEN=AAAA:XXXXX
    volumes:
      - telegrambot:/data

  unsee:
    image: cloudflare/unsee:v0.8.0
    ports:
      - 8080:8080
    environment:
      - ALERTMANAGER_URIS=default:http://alertmanager:9093

volumes:
  alertmanager:
  telegrambot:

```

To test a sample alert:
```
curl -H "Content-Type: application/json" -d '[{"labels":{"alertname":"TestAlert1"}}]' localhost:9093/api/v1/alerts
```
