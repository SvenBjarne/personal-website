# syntax = docker/dockerfile:1

ARG NODE_VERSION=20.18.0
FROM node:${NODE_VERSION}-slim as base

LABEL fly_launch_runtime="Node.js"

WORKDIR /app

ENV NODE_ENV="production"

FROM base as build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential node-gyp pkg-config python-is-python3


COPY package.json ./
RUN npm install

COPY . .

FROM base

COPY --from=build /app /app

RUN npm install -g nodemon
RUN npm install -g nodemon ts-node


EXPOSE 3000
CMD [ "npm", "run", "start" ]
