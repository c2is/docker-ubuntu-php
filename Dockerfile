FROM ubuntu:bionic

MAINTAINER André Cianfarani <a.cianfarani@c2is.fr>

RUN \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y php-common php7.1-cli php7.1-fpm php7.1-mysql php7.1-curl php7.1-gd php7.1-intl php7.1-xml php7.1-xmlrpc php7.1-zip php7.1-dom php7.1-imagick php7.1-xsl php7.1-mbstring && \
    apt-get install -y ssmtp && \
    apt-get --purge remove -y software-properties-common && \
    apt-get -y autoremove && \
    apt-get clean && \
    echo "FromLineOverride=YES" >> /etc/ssmtp/ssmtp.conf && \
    echo "root=postmaster" >> /etc/ssmtp/ssmtp.conf && \
    echo "mailhub=mail" >> /etc/ssmtp/ssmtp.conf && \
    echo "AuthUser=web" >> /etc/ssmtp/ssmtp.conf && \
    echo "AuthPass=web" >> /etc/ssmtp/ssmtp.conf && \
    echo "hostname=acti.fr" >> /etc/ssmtp/ssmtp.conf && \
    echo "root:web:mail" >> /etc/ssmtp/revaliases && \
    echo 'sendmail_path = "/usr/sbin/ssmtp -t"' >> /etc/php/7.1/fpm/php.ini && \
    sed -i "s|listen = /run/php/php7.1-fpm.sock|listen = 9000|ig" /etc/php/7.1/fpm/pool.d/www.conf

RUN service php7.1-fpm start
CMD ["php-fpm7.1", "-F"]

EXPOSE 9000

