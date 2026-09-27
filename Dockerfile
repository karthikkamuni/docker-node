# Stage 1
FROM node:22-alpine AS dependencies
WORKDIR /nodeapp
COPY package*.json ./
RUN npm ci --omit=dev

# Stage 2
FROM node:22-alpine AS prod
WORKDIR /nodeapp
COPY --from=dependencies --chown=node:node /nodeapp/node_modules ./node_modules
COPY --chown=node:node package*.json ./
COPY --chown=node:node . .
EXPOSE 3000
USER node
CMD ["npm", "start"]
