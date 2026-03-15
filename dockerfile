FROM nginx:stable-alpine3.23-perl
RUN apt-get update && apt-get install -y nginx
