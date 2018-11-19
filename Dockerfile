#Phase 1: Builder
FROM node:alpine as builder
#Establish your docker PWD(Present Working Directory)
WORKDIR '/app'
#First we copy the package.json, as a technique to prevent docker build from
#busting the cache eveytime source code has changed
COPY package.json .
# install node_modules
RUN npm install
# Copy all source code to docker
COPY . .
#Build the minified reseources and assets
RUN npm run build

#Phase 2: NGINX
FROM nginx
EXPOSE 80
#Copy builder phase into the nginx phase
#Served up static html files
COPY --from=builder /app/build /usr/share/nginx/html

