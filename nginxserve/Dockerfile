FROM nginx:stable-alpine

RUN apk add --no-cache openssl
RUN mkdir -p /etc/nginx/ssl && mkdir -p /srv/data

COPY default.conf /etc/nginx/conf.d/
COPY run.sh /
ENTRYPOINT [ "/run.sh"]
