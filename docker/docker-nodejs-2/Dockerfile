FROM node

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 8085

ENTRYPOINT [ "npm","start" ]