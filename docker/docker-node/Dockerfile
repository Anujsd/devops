FROM node

WORKDIR /app

COPY package.json /app

RUN npm install

COPY . /app
# does nothing works without this
# but for better understanding we kept it here
EXPOSE 8085 

ENTRYPOINT [ "node","index.js" ]