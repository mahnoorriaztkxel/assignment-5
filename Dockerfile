# FROM  node:18-alpine
# WORKDIR /app
# COPY package.json package-lock.json ./
# COPY . .
# RUN npm install
# CMD ["npm","run","start"]


# # Stage 1: Build the React app
# FROM node:lts as builder
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .
# RUN npm run build
# # Stage 2: Create the production image
# FROM nginx:latest
# COPY --from=builder /app/build /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]


# Stage 1: Build React app
FROM node:lts AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:latest
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

