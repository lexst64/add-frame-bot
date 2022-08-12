# Build
FROM node:16-alpine AS build
WORKDIR /usr/src/add-frame-bot
COPY package*.json ./
RUN npm ci --ignore-scripts
COPY tsconfig*.json ./
COPY ./src ./src
RUN npm run build

# Deploy
FROM node:16-alpine
WORKDIR /usr/src/add-frame-bot
COPY package*.json ./
RUN npm ci --omit=dev --ignore-scripts
COPY --from=build /usr/src/add-frame-bot/dist ./dist
CMD npm run serve