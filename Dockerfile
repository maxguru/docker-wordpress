FROM wordpress:php7.4

RUN apt-get update \
&& apt-get upgrade -yq --no-install-recommends --no-install-suggests \
&& apt-get install -yq --no-install-recommends --no-install-suggests libxml2-dev libc-client-dev libkrb5-dev cron curl \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
&& docker-php-ext-install soap fileinfo imap

COPY crontab /etc/cron.d/wordpress
# TODO: add "define('DISABLE_WP_CRON', true);" to wp-config.php
