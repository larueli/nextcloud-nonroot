FROM larueli/php-base-image:8.2

USER 0

ARG NEXTCLOUD_VERSION=26.0.2

COPY site.conf /etc/apache2/sites-available/000-default.conf
COPY nextcloud-php.ini /usr/local/etc/php/conf.d/nextcloud-php.ini

RUN apt-get update && apt-get install -y ffmpeg && \
    wget https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VERSION}.zip && unzip nextcloud-${NEXTCLOUD_VERSION}.zip && rm nextcloud-${NEXTCLOUD_VERSION}.zip && \
    mv nextcloud/* /var/www/html/ && rm -rf nextcloud && sed -i 's|^Timeout.*$|Timeout 3600|g' /etc/apache2/apache2.conf && \
    a2enmod headers && a2enmod env && a2enmod dir && a2enmod mime && a2enmod rewrite && \
    chown 1420 -R /var/www/html && chmod g=rwx -R /var/www/html

USER 1420:0

