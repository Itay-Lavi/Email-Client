FROM node:slim

ENV PORT=8000
ENV JWT_SECRET="secret"

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN npx tsc

CMD ["node", "dist/app.js"]