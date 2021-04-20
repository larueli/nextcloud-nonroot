FROM larueli/php-base-image:7.4

USER 0

ARG NEXTCLOUD_VERSION=21.0.1

COPY site.conf /etc/apache2/sites-available/000-default.conf

RUN apt-get update && apt-get install -y ffmpeg && \
    wget https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VERSION}.zip && unzip nextcloud-${NEXTCLOUD_VERSION}.zip && rm nextcloud-${NEXTCLOUD_VERSION}.zip && \
    mv nextcloud/* /var/www/html/ && rm -rf nextcloud && sed -i 's|^Timeout.*$|Timeout 3600|g' /etc/apache2/apache2.conf && \
    a2enmod headers && a2enmod env && a2enmod dir && a2enmod mime && a2enmod rewrite && \
    chmod g=rwx -R /var/www/html

USER 1420:0

