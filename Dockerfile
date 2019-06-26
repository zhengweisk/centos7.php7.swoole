FROM centos:7
MAINTAINER sklinux <sklinux@qq.com>
ADD epel-release-latest-7.noarch.rpm /tmp/epel-release-latest-7.noarch.rpm
ADD ius-release.rpm /tmp/ius-release.rpm
#RUN rpm -Uvh  https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh  /tmp/epel-release-latest-7.noarch.rpm && rpm -Uvh /tmp/ius-release.rpm
#RUN rpm -Uvh  https://centos7.iuscommunity.org/ius-release.rpm

RUN  yum -y install php72u php72u-bcmath php72u-cli php72u-common php72u-dba php72u-dbg php72u-debuginfo php72u-devel php72u-embedded php72u-enchant php72u-fpm php72u-fpm-httpd php72u-fpm-nginx php72u-gd php72u-gmp php72u-imap php72u-interbase php72u-intl php72u-json php72u-ldap php72u-mbstring php72u-mcrypt php72u-mysqlnd php72u-odbc php72u-opcache php72u-pdo php72u-pdo-dblib php72u-pgsql php72u-process php72u-pspell php72u-recode php72u-snmp php72u-soap php72u-tidy php72u-xml php72u-xmlrpc php72u-pecl-* pcre-devel openssl-devel gcc gcc-c++ glibc-headers zip unzip msodbcsql mssql-tools unixODBC-devel net-tools


WORKDIR /opt/src
#RUN wget http://pear.php.net/go-pear.phar
ADD go-pear.phar /opt/src/go-pear.phar
ADD v4.4.0-beta.zip /opt/src/v4.4.0-beta.zip
RUN php go-pear.phar
RUN unzip v4.4.0-beta.zip && ls -lh && cd swoole-src-4.4.0-beta && phpize && ./configure --enable-sockets --enable-openssl --enable-swoole-debug && make && make install && echo extension=swoole.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/20-swoole.ini
#RUN  curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssqlrelease.repo 
ADD prod.repo /etc/yum.repos.d/mssqlrelease.repo
RUN pecl install sqlsrv 
RUN pecl install pdo_sqlsrv
RUN echo extension=pdo_sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/30-pdo_sqlsrv.ini
RUN echo extension=sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/20-sqlsrv.ini
ADD jiacrontab /opt/jiacrontab
ADD start.sh /opt/start.sh
EXPOSE 20000
CMD /opt/start.sh
