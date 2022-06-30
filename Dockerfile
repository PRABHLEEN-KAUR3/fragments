# Use node version 16.15.0
FROM node:16.15.0

LABEL maintainer="Prabhleen Kaur <prabhleen-kaur3@myseneca.ca>"
LABEL description="Fragments node.js microservice"

# We default to use port 8080 in our service
ENV PORT=8080

# Reduce npm spam when installing within Docker
# https://docs.npmjs.com/cli/v8/using-npm/config#loglevel
ENV NPM_CONFIG_LOGLEVEL=warn

# Disable colour when run inside Docker
# https://docs.npmjs.com/cli/v8/using-npm/config#color
ENV NPM_CONFIG_COLOR=false

# Use /app as our working directory
WORKDIR /app

# Copy the package.json and package-lock.json files into /app
COPY package*.json /app/
# Copy the package.json and package-lock.json files into the working dir (/app)
COPY package*.json ./
# Copy the package.json and package-lock.json files into the working dir (/app)
COPY package.json package-lock.json ./

# Install node dependencies defined in package-lock.json
RUN npm install

# Copy src to /app/src/
COPY ./src ./src

# Start the container by running our server
CMD npm start

# We run our service on port 8080
EXPOSE 8080

# Copy src/
COPY ./src ./src

# Copy our HTPASSWD file
COPY ./tests/.htpasswd ./tests/.htpasswd

# Run the server
CMD npm start

# ------------ Dockefile Optimization - Lab-6 - Part 20 -------------------
# Create a new user (including a home-directory, which is optional)
RUN useradd --create-home appuser
# Switch to this user
USER appuser

# Stage 0: Install alpine Linux + node + yarn + dependencies
FROM node:16.15.1-alpine@sha256:294ed7085d137d4f16fd97c0e1518f1d0386dd7fda7c4897d82c7ba65e15fdd6 AS dependencies

ENV NODE_ENV=production

WORKDIR /app

# copy dep files and install the production deps
COPY package.json yarn.lock ./
RUN yarn

#################
FROM node:16.15.1-alpine@sha256:294ed7085d137d4f16fd97c0e1518f1d0386dd7fda7c4897d82c7ba65e15fdd6

COPY docker-entrypoint.sh /usr/local/bin/

RUN apt-get update && apt-get install -y nginx

ENTRYPOINT ["/docker-entrypoint.sh"]

#######################################################################
#Stage 1: use dependencies + nginx web server to host the web site
FROM nginx:16.15.1-alpine@sha256:294ed7085d137d4f16fd97c0e1518f1d0386dd7fda7c4897d82c7ba65e15fdd6

# Copy cached dependencies from previous stage so we don't have to download
COPY --from=dependencies /app /app

# Copy source code into the image
COPY . ./app

#Put our app/ into /usr/share/nginx/html/ and host static files
COPY . /usr/share/nginx/html/

#Expose Port
EXPOSE 80


#Health Check 
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
CMD curl --fail localhost:80 || exit 1

