FROM node:18-alpine

WORKDIR /usr/src/app

COPY app/package*.json ./
RUN npm install

COPY app/ .

# # Intentionally planted problem 3: Secret hardcode

# Intentionally planted problem 2: Typo in variable name

CMD [ "npm", "start" ]
