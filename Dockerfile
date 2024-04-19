# Preparing bower files (only have bower in dev dependencies)
FROM node

RUN mkdir /app
WORKDIR /app

COPY package.json /app/
RUN npm install

COPY .bowerrc /app/
COPY bower.json /app/
RUN npm run bowerInstallDocker


FROM node

RUN apt-get update && apt-get upgrade -y \
    && apt-get clean
//added the line to the
//sifgiu dighfw
RUN mkdir /app
WORKDIR /app

COPY --from=0 /app/src/public/static/bower_components/ /app/src/public/static/bower_components/

COPY package.json /app/
RUN npm install
# --only=production this is a change to check the merge command functionality ..........

COPY src /app/src

EXPOSE 3000

CMD [ "npm", "start" ]

RUN ls -lah /app/src/public/static/bower_components/
