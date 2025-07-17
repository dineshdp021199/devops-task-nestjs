FROM node:18-slim AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build


FROM node:18-slim AS run

WORKDIR /app

COPY package*.json ./

RUN npm install


COPY --from=build /app/dist ./dist

COPY --from=build /app/ormconfig.json ./ormconfig.json

EXPOSE 3000

CMD ["node", "dist/main"]

