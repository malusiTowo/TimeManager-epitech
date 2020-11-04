FROM dmastag/alpine-node-openjdk-android-cordova as mobile_builder

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN cd src-cordova && \
  cordova build android && \
  cp /app/src-cordova/platforms/android/app/build/outputs/apk/debug/app-debug.apk /app/public


FROM node as web_builder


WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

COPY --from=mobile_builder /app/public /app/public

RUN npm run build

FROM node:alpine

WORKDIR /app

RUN npm install -g http-server

COPY  --from=web_builder /app/dist /app

CMD http-server ./