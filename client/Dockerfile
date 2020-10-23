# # develop stage
# FROM node  as develop-stage

# WORKDIR /app

# COPY package*.json ./

# RUN npm install

# COPY . .

# CMD npm run serve

FROM node

RUN npm install -g http-server

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

EXPOSE 8080

CMD [ "http-server", "dist" ]