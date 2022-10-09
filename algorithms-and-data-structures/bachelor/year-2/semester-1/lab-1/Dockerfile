FROM node:16.17.1-alpine

# Create app directory
RUN mkdir -p /app
WORKDIR /app

# Install app dependencies
COPY . /app
RUN pnpm install

# Bundle app source
COPY . /app
RUN pnpm build:clean && pnpm build
