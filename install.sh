#!/bin/bash
# NginxID.com command line installer NGINX for CentOS
yum clean all && yum -y update && yum -y upgrade
arch=`uname -m`
OS_MAJOR_VERSION=`sed -rn 's/.*([0-9])\.[0-9].*/\1/p' /etc/redhat-release`
OS_MINOR_VERSION=`sed -rn 's/.*[0-9].([0-9]).*/\1/p' /etc/redhat-release`
if [ "$arch" = "x86_64" ]; then
    if [ "$OS_MAJOR_VERSION" = 5 ]; then
        rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm;
        rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-5.rpm;
    else 
        rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm;
        rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm;
    fi
else
    if [ "$OS_MAJOR_VERSION" = 5 ]; then
        rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm;
        rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-5.rpm;
    else 
        rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm;
        rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm;
    fi
fi
echo "[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1" >> /etc/yum.repos.d/nginx.repo
yum -y --enablerepo=remi,remi-test install nginx mysql mysql-server php php-common php-fpm
yum -y --enablerepo=remi,remi-test install php-mysql php-pgsql php-sqlite php-pecl-memcache php-gd php-mbstring php-mcrypt php-xml php-pecl-apc php-cli php-pear php-pdo
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php.ini
sed -i 's/user = apache/user = nginx/g' /etc/php-fpm.d/www.conf
sed -i 's/group = apache/group = nginx/g' /etc/php-fpm.d/www.conf
chkconfig --levels 235 httpd off && service httpd stop
chkconfig --add nginx && chkconfig --add mysqld && chkconfig --add php-fpm
chkconfig --levels 235 nginx on && chkconfig --levels 235 mysqld on && chkconfig --levels 235 php-fpm on
service nginx start && service mysqld start && service php-fpm start
rm -rf /etc/nginx/conf.d/default.conf
echo "server {
    listen       80;
    server_name  localhost;
 
    #charset koi8-r;
    #access_log  /var/log/nginx/log/host.access.log  main;
 
    location / {
        root   /usr/share/nginx/html;
        index index.php index.html index.htm;
    }
 
    error_page  404              /404.html;
 
    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
 
    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}
 
    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    location ~ \.php$ {
        root           html;
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  \$document_root\$fastcgi_script_name;
        include        fastcgi_params;
    }
 
    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}
}" >> /etc/nginx/conf.d/default.conf
service nginx restart
yum -y install figlet
figlet -ctf standard "R E A D M E"
figlet -ctf term "Jika ada output seperti dibawah ini"
figlet -ctf term "Enter current password for root (enter for none):"
figlet -ctf term "maka tekan ENTER"
figlet -ctf term "jika ada pertanya Y/N maka di tekan Y dan tekan ENTER"
figlet -ctf term "di bagian setup password MySQL, masukkan password yang di inginkan sebanyak 2 kali, dengan password yang sama"
figlet -ctf term "step berikutnya ada 4 pertanya Y/N maka di tekan Y dan tekan ENTER"
/usr/bin/mysql_secure_installation
service mysqld restart
service mysqld status
service php-fpm status
service nginx status
nginx -t
mv /usr/share/nginx/html/index.html /usr/share/nginx/html/index-original.html
wget https://raw.githubusercontent.com/NginxID/nginx-remi-repository-installer/master/index.html
mv index.html /usr/share/nginx/html/
wget https://sourceforge.net/projects/phpmyadmin/files/latest/download?source=files
yum -y install zip unzip
unzip download?source=files -d /usr/share/nginx/html
mv /usr/share/nginx/html/phpMyAdmin*all-languages /usr/share/nginx/html/e5946629d0ca8788d4ca5a1ba61074bd
mv /usr/share/nginx/html/e5946629d0ca8788d4ca5a1ba61074bd/config.sample.inc.php /usr/share/nginx/html/e5946629d0ca8788d4ca5a1ba61074bd/config.inc.php
sed -i 's/'cookie'/'http'/g' /usr/share/nginx/html/phpMyAdmin*all-languages/config.inc.php
figlet -ctf term "==============================================================="
figlet -ctf term "Your documents root (default): /usr/share/nginx/html/"
figlet -ctf term "Your phpMyAdmin: http://IP/e5946629d0ca8788d4ca5a1ba61074bd"
figlet -ctf term "How to Adding Virtual Hosts: https://asciinema.org/a/14192"
echo ""
figlet -ctf term "Thanks to:"
figlet -ctf standard "N G I N X"
figlet -ctf digital "Nginx Indonesia"
figlet -ctf term "==============================================================="
exit
