FROM nginx:alpine
RUN mkdir -p /var/www/certbot
COPY default.conf /etc/nginx/conf.d/default.conf
COPY html/ /usr/share/nginx/html/
