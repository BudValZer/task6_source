FROM ubuntu:latest

LABEL Name="nginx" org.opencontainers.image.authors="BudValZer"

ENV DEVOPS="#"

SHELL ["/bin/bash", "-c"]
RUN apt update && \
    apt install nginx gettext-base -y && \
    apt autoremove -y && \
    apt clean -y && \
    rm /var/www/html/* && \
    rm /etc/nginx/sites-enabled/* && \
    mkdir /docker-entrypoint.d

COPY docker-entrypoint.sh /
COPY 20-envsubst-on-templates.sh /docker-entrypoint.d/

RUN chmod +x /docker-entrypoint.sh && \
    chmod +x /docker-entrypoint.d/20-envsubst-on-templates.sh

COPY index.html /var/www/html/
COPY default.conf.template /etc/nginx/templates/

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
