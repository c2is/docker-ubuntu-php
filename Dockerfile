FROM ubuntu:trusty

MAINTAINER André Cianfarani <a.cianfarani@c2is.fr>

RUN apt-get update && \ 
 apt-get install -y php5-common php5-cli php5-fpm php5-mysql php5-curl php5-gd php5-intl php5-xmlrpc php5-imagick php5-xsl php5-mcrypt && \
 apt-get install -y ssmtp && \   
 apt-get clean && \
 echo "FromLineOverride=YES" >> /etc/ssmtp/ssmtp.conf && \
 echo "root=postmaster" >> /etc/ssmtp/ssmtp.conf && \
 echo "mailhub=mail" >> /etc/ssmtp/ssmtp.conf && \
 echo "AuthUser=web" >> /etc/ssmtp/ssmtp.conf && \
 echo "AuthPass=web" >> /etc/ssmtp/ssmtp.conf && \
 echo "hostname=acti.fr" >> /etc/ssmtp/ssmtp.conf && \
 echo "root:web:mail" >> /etc/ssmtp/revaliases && \
 echo 'sendmail_path = "/usr/sbin/ssmtp -t"' >> /etc/php5/fpm/php.ini && \
 sed -i "s|listen = /run/php/php7.0-fpm.sock|listen = 9000|ig" /etc/php5/fpm/pool.d/www.conf
 

RUN service php5-fpm start
CMD ["php5-fpm", "-F"]

EXPOSE 9000

