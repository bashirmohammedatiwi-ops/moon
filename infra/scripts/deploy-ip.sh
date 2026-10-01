#!/usr/bin/env bash
# Deploy قمر الزمان on VPS using IP only (HTTP on port 3200, no domain/SSL/certbot).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ ! -f .env ]]; then
  echo "Copy .env.example to .env and set DOMAIN to your VPS IP:3200 (e.g. 187.127.88.146:3200)."
  exit 1
fi

set -a
source .env
set +a

: "${DOMAIN:?Set DOMAIN to your VPS IP:port in .env}"
export COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-qamar}"

cp nginx/default.bootstrap.conf nginx/default.conf

# Ensure nginx paths use /var/www/qamar (bootstrap already updated in this repo)
if grep -q '/var/www/alhayaa' nginx/default.conf 2>/dev/null; then
  sed -i.bak 's|/var/www/alhayaa|/var/www/qamar|g; s|upstream alhayaa_api|upstream qamar_api|g; s|http://alhayaa_api|http://qamar_api|g' nginx/default.conf
  rm -f nginx/default.conf.bak
fi

cat > docker-compose.override.yml <<EOF
services:
  api:
    environment:
      MEDIA_PUBLIC_BASE_URL: http://${DOMAIN}/media
      ENABLE_HSTS: "0"
  catalog-hub:
    environment:
      AMAZON_AUTO_CRAWL: "0"
      AMAZON_ACCESS_KEY: ""
      AMAZON_SECRET_KEY: ""
  nginx:
    depends_on:
      api:
        condition: service_started
EOF

echo "==> Building and starting قمر الزمان (HTTP on host port 3200)..."
echo "==> Tip: set RUN_SEED=0 in .env if startup is slow; seed manually later."
echo "==> Do NOT run watch-miswag-scan / certbot — reserved for the base app."
docker compose -f docker-compose.prod.yml up -d --build

echo "==> Building admin web panel..."
chmod +x scripts/build-admin-web.sh
./scripts/build-admin-web.sh
docker compose -f docker-compose.prod.yml up -d nginx

echo ""
echo "Wait 2-3 minutes, then:"
echo "  docker compose -f docker-compose.prod.yml logs api --tail=30"
echo "  curl http://${DOMAIN}/api/v1/health"
echo "  Admin panel: http://${DOMAIN}/"
echo "  Mobile API:  http://${DOMAIN}/api/v1"
