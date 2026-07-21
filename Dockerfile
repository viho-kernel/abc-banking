FROM node:22.18-alpine

WORKDIR /app

#copying all dependencies
COPY app/package*.json ./

#installing dependencies
RUN npm ci

COPY app/ .

EXPOSE 3000

CMD [ "npm", "start" ]