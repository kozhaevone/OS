FROM debian
ADD debian.list /etc/apt/sources.list.d/
RUN apt-get update && apt-get -y upgrade && apt -y install nginx && apt-get clean && \
    cd /var/www/ && rm -rf ./* && \
    mkdir -p kozhaevone.com/img && \
    chmod -R 754 /var/www/kozhaevone.com/ && \
    useradd Dima && groupadd Kozhaev && usermod -aG Kozhaev Dima && \
    chown -R Dima:Kozhaev /var/www/kozhaevone.com/ && \
    sed -i 's/\/var\/www\/html/\/var\/www\/kozhaevone.com/g' /etc/nginx/sites-enabled/default && \
    sed -i 's/user www-data/user Dima/g' /etc/nginx/nginx.conf
ADD index.html /var/www/kozhaevone.com/
ADD img.jpg /var/www/kozhaevone.com/img/
CMD ["nginx", "-g", "daemon off;"]
