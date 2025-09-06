# Use the latest LTS version of Node.js
FROM node:20-alpine AS build

# Set the working directory inside the container
WORKDIR /app
COPY package.json ./
RUN npm install npm@latest
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]


# Production Stage
FROM nginx:stable-alpine AS production
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]