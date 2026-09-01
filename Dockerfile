FROM node:18-alpine

WORKDIR /usr/src/app

COPY app/package*.json ./
RUN npm install

COPY app/ .

# Intentionally planted problem 3: Secret hardcoded
# (Removed to be injected at runtime)

# Intentionally planted problem 2: Typo in variable name
# (Removed to be injected at runtime via .env)

CMD [ "npm", "start" ]
