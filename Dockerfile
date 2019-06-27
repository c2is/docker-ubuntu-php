FROM ubuntu:bionic

MAINTAINER André Cianfarani <a.cianfarani@c2is.fr>

RUN \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y php-common php5.6-cli php5.6-fpm php5.6-mysql php5.6-curl php5.6-gd php5.6-intl php5.6-xml php5.6-xmlrpc php5.6-zip php5.6-dom php5.6-imagick php5.6-xsl php5.6-mbstring && \
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
    echo 'sendmail_path = "/usr/sbin/ssmtp -t"' >> /etc/php/5.6/fpm/php.ini && \
    sed -i "s|listen = /run/php/php5.6-fpm.sock|listen = 9000|ig" /etc/php/5.6/fpm/pool.d/www.conf

RUN service php5.6-fpm start
CMD ["php-fpm5.6", "-F"]

EXPOSE 9000

