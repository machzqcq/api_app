FROM node:4.4-wheezy

RUN useradd --user-group --create-home --shell /bin/false app &&\
  npm install --global npm@3.7.2

ARG NEXUS_SERVER
ENV HOME=/home/app
# COPY package.json $HOME/api_app/
COPY package.json app.js $HOME/api_app/
RUN chown -R app:app $HOME/*

USER app
WORKDIR $HOME/api_app
RUN npm config set registry http://$NEXUS_SERVER:18082/repository/npmproxy/
RUN npm install && npm cache clean
EXPOSE 3412
CMD ["node_modules/.bin/nodemon"]
