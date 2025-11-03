# ssl 인증서 최초 발급 명령어
```bash
docker compose run --rm certbot certonly \
  --webroot -w /etc/nginx/certbot/www \
  -d gitlab.smartseoapp.com \
  --email 5432tat@naver.com \
  --agree-tos \
  --no-eff-email
```