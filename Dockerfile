FROM wordpress:5.3-php7.3-apache

COPY wp.ini /usr/local/etc/php/

RUN pecl install -f xdebug && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini;

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer
