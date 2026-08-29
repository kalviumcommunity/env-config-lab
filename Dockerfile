FROM node:18-alpine

WORKDIR /usr/src/app

COPY app/package*.json ./
RUN npm install

COPY app/ .

# DATABASE_URL, LOG_LEVEL, API_KEY are provided at runtime
# (--env-file .env for config, -e API_KEY=... for the secret) — never baked
# into the image.

CMD [ "npm", "start" ]
