FROM node:16.18

ENV PORT=3000

COPY . /frontend-react-js
WORKDIR /frontend-react-js

# install app dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install --silent


RUN npm install
EXPOSE ${PORT}
CMD ["npm", "start"]
