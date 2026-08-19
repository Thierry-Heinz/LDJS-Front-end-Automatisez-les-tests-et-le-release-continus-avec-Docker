FROM node:22 AS build

WORKDIR /app

COPY package.json package-lock.json ./

COPY tsconfig.json tailwind.config.js jest.config.js index.html babel.config.json README.md postcss.config.js vite.config.ts ./

RUN npm install

COPY ./src  ./src
COPY ./public ./public
COPY ./tests ./tests

RUN npm run build


FROM nginx
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /app

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
