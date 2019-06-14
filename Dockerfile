FROM ubuntu:bionic

MAINTAINER André Cianfarani <a.cianfarani@c2is.fr>

RUN \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y php-common php7.3-cli php7.3-fpm php7.3-mysql php7.3-curl php7.3-gd php7.3-intl php7.3-xml php7.3-xmlrpc php7.3-zip php7.3-dom php7.3-imagick php7.3-xsl php7.3-mbstring msmtp && \
    apt-get --purge remove -y software-properties-common && \
    apt-get -y autoremove && \
    apt-get clean && \
    echo "account default" >  /etc/msmtprc && \
    echo "host mailhog" >> /etc/msmtprc && \
    echo "port 1025" >> /etc/msmtprc && \
    echo "from default@dev.acti" >> /etc/msmtprc && \
    echo "logfile /var/log/msmtp.log" >> /etc/msmtprc && \
    echo "sendmail_path=/usr/bin/msmtp -t" >> /etc/php/7.3/fpm/php.ini && \
    echo "sendmail_path=/usr/bin/msmtp -t" >> /etc/php/7.3/cli/php.ini && \
    sed -i "s|listen = /run/php/php7.3-fpm.sock|listen = 9000|ig" /etc/php/7.3/fpm/pool.d/www.conf

RUN service php7.3-fpm start
CMD ["php-fpm7.3", "-F"]

EXPOSE 9000

