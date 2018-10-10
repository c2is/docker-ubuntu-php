FROM ubuntu:xenial

MAINTAINER André Cianfarani <a.cianfarani@c2is.fr>

RUN apt-get update && \ 
 apt-get install -y php-common php-cli php-fpm php-mysql php-curl php-gd php-intl php-xml php-xmlrpc php-zip php-dom php-imagick php-xsl php-mcrypt && \
 apt-get install -y ssmtp && \   
 apt-get clean && \
 echo "FromLineOverride=YES" >> /etc/ssmtp/ssmtp.conf && \
 echo "root=postmaster" >> /etc/ssmtp/ssmtp.conf && \
 echo "mailhub=mail" >> /etc/ssmtp/ssmtp.conf && \
 echo "AuthUser=web" >> /etc/ssmtp/ssmtp.conf && \
 echo "AuthPass=web" >> /etc/ssmtp/ssmtp.conf && \
 echo "hostname=acti.fr" >> /etc/ssmtp/ssmtp.conf && \
 echo "root:web:mail" >> /etc/ssmtp/revaliases && \
 echo 'sendmail_path = "/usr/sbin/ssmtp -t"' >> /etc/php/7.0/fpm/php.ini && \
 sed -i "s|listen = /run/php/php7.0-fpm.sock|listen = 9000|ig" /etc/php/7.0/fpm/pool.d/www.conf
 

RUN service php7.0-fpm start
CMD ["php-fpm7.0", "-F"]

EXPOSE 9000

