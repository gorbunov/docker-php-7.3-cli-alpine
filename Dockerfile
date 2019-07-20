FROM php:7.3-cli-alpine
LABEL maintainer="Oleg Gorbunov <dev.oleg.gorbunov@gmail.com>"
RUN echo 'nameserver 8.8.8.8' > /etc/resolv.conf \
    && echo "ipv6" >> /etc/modules
RUN apk update \
    && apk --update --no-cache add ca-certificates wget rsync curl git openssh php php-curl php-openssl php-json php-phar \
    && update-ca-certificates
RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-enable pdo_mysql opcache \
    && { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } \
    && rm /var/cache/apk/*
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN chmod +x /usr/local/bin/composer
RUN mkdir /current
WORKDIR /current
VOLUME /current
