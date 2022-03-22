FROM node:17-alpine3.15 as base

ADD ./ /opt/app
WORKDIR /opt/app

USER root

RUN rm -rf node_modules \
 && chown -R node /opt/app


FROM base as build

RUN npm install \
 && chown -R node /opt/app

EXPOSE 3000

USER node

CMD [ "node", "app.js" ]