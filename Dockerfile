FROM node:18-alpine

WORKDIR /usr/src/app

COPY app/package*.json ./
RUN npm install

COPY app/ .

# Fixed typo in variable name (LOGLEVEL -> LOG_LEVEL)
# Note: Sensitive secrets (such as API_KEY) have been removed from the Dockerfile and are injected at runtime.
ENV LOG_LEVEL=info

CMD [ "npm", "start" ]
