FROM ubuntu:bionic

MAINTAINER André Cianfarani <a.cianfarani@c2is.fr>

RUN \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y php-common php7.4-cli php7.4-fpm php7.4-mysql php7.4-curl php7.4-gd php7.4-intl php7.4-xml php7.4-xmlrpc php7.4-zip php7.4-dom php7.4-imagick php7.4-xsl php7.4-mbstring && \
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
    echo 'sendmail_path = "/usr/sbin/ssmtp -t"' >> /etc/php/7.4/fpm/php.ini && \
    sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|ig" /etc/php/7.4/fpm/pool.d/www.conf

RUN service php7.4-fpm start
CMD ["php-fpm7.4", "-F"]

EXPOSE 9000

