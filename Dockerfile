FROM wordpress:5.5-php7.3-apache
RUN apt-get update && apt-get install -yqq git

COPY wp.ini /usr/local/etc/php/conf.d/

RUN pecl install -f xdebug && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini;

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer
RUN curl -Lsf https://dl.google.com/go/go1.14.linux-amd64.tar.gz | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
