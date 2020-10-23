# develop stage
FROM node  as develop-stage

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

CMD npm run serve