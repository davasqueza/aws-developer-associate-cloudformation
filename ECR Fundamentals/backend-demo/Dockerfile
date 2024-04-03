FROM node:lts-alpine3.19

WORKDIR /app

ENV PORT 80

COPY package.json ./package.json
COPY package-lock.json ./package-lock.json
RUN npm ci

COPY src ./src

CMD [ "node", "src/index.js" ]
