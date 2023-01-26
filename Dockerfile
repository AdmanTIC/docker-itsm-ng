FROM php:8.0-apache

ARG ITSM_VERSION=1.3.0
ENV DEBIAN_FRONTEND noninteractive
SHELL ["/bin/bash", "-c"]

RUN set -exuo pipefail \
  && apt update \
  && apt install --yes --no-install-recommends \
    wget \
    cron \
    ca-certificates \
    jq \
    mariadb-client \
    gettext-base \
    libldap-2.4-2 \
    libldap-common \
    libsasl2-2 \
    libsasl2-modules \
    libsasl2-modules-db \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libpng-dev \
    libicu-dev \
    libc-client-dev \
    libkrb5-dev \
    libldb-dev \
    libldap2-dev \
    libzip-dev \
    libbz2-dev \
    libmcrypt-dev \
  && mkdir -p /usr/src/php/ext/apcu && curl -fsSL https://pecl.php.net/get/apcu | tar xvz -C "/usr/src/php/ext/apcu" --strip 1 \
  && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \ 
  && docker-php-ext-install gd intl mysqli exif imap ldap zip bz2 opcache apcu\
  && a2enmod rewrite \
  && curl -sfL https://github.com/itsmng/itsm-ng/releases/download/v${ITSM_VERSION}/itsm-ng-${ITSM_VERSION}.tgz | tar zx --strip-components=1 -C /var/www/html \
  && mv /var/www/html/files /var/www/html/files.default \
  && rm -rf /var/lib/apt/lists/* /var/www/html/install/install.php

COPY install/ /

ENTRYPOINT ["/init.sh"]
