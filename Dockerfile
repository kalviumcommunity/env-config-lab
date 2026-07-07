FROM node:18-alpine

WORKDIR /usr/src/app

COPY app/package*.json ./
RUN npm install

COPY app/ .

# Intentionally planted problem 3: Secret hardcoded
ENV API_KEY=super-secret-key

# Intentionally planted problem 2: Typo in variable name
ENV LOGLEVEL=info

CMD [ "npm", "start" ]
