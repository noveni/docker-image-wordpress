FROM wordpress:6.0.3-php8.1-apache

# Install packages under Debian
RUN apt-get update && \
    apt-get -y install git

# Install Xdebug
RUN pecl install -f xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)\nxdebug.mode=debug\nxdebug.start_with_request=yes" > /usr/local/etc/php/conf.d/xdebug.ini;


COPY wp.ini /usr/local/etc/php/conf.d/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Install a sendmail operator
RUN curl -Lsf https://dl.google.com/go/go1.14.linux-amd64.tar.gz | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
