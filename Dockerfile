FROM alpine

RUN apk --update add --no-cache nginx curl supervisor php7 php7-dom php7-fpm php7-mbstring php7-mcrypt php7-opcache php7-pdo php7-pdo_mysql php7-pdo_pgsql php7-pdo_sqlite php7-pgsql php7-mysqli php7-tokenizer php7-fileinfo php7-imap php7-calendar php7-xml php7-phar php7-openssl php7-json php7-curl php7-ctype php7-session php7-gd php7-imagick php7-zip vim git

RUN rm -Rf /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

COPY conf/nginx/nginx.conf /etc/nginx/nginx.conf

COPY conf/nginx/supervisord.conf /etc/supervisord.conf

RUN mkdir -p /app

RUN chmod -R 755 /app

WORKDIR /app

EXPOSE 80 80

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
# credits: http://petronetto.com.br/2017/05/08/criando-uma-aplicacao-laravel-com-docker
