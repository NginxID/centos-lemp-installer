#!/bin/bash
# NginxID.com command line installer NGINX for CentOS
yum clean all && yum -y update && yum -y upgrade
rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
echo "[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1" >> /etc/yum.repos.d/nginx.repo
yum -y --enablerepo=remi,remi-test install nginx mariadb-server mariadb php php-common php-fpm
yum -y --enablerepo=remi,remi-test install php-mysql php-pgsql php-pecl-memcache php-gd php-mbstring php-mcrypt php-xml php-pecl-apc php-cli php-pear php-pdo
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php.ini
sed -i 's/user = apache/user = nginx/g' /etc/php-fpm.d/www.conf
sed -i 's/group = apache/group = nginx/g' /etc/php-fpm.d/www.conf
systemctl start nginx.service
systemctl enable nginx.service
systemctl start mariadb
systemctl enable mariadb.service
systemctl start php-fpm
systemctl enable php-fpm.service

rm -rf /etc/nginx/nginx.conf
echo "# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user  nginx;
worker_processes  1;

error_log  /var/log/nginx/error.log;
#error_log  /var/log/nginx/error.log  notice;
#error_log  /var/log/nginx/error.log  info;

pid        /run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    index   index.html index.htm;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80 default_server;
        server_name  localhost;
        root         /usr/share/nginx/html;

        #charset koi8-r;

        #access_log  /var/log/nginx/host.access.log  main;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
        root   /usr/share/nginx/html;
        index index.php index.html index.htm;
        }

        # redirect server error pages to the static page /40x.html
        #
        error_page  404              /404.html;
        location = /40x.html {
        }

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
        }
        location ~ \.php$ {
                root           html;
                fastcgi_pass   127.0.0.1:9000;
                fastcgi_index  index.php;
                fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
                include        fastcgi_params;
        }
    }
}" >> /etc/nginx/nginx.conf
systemctl restart nginx
yum -y install figlet
figlet -ctf standard "R E A D M E"
figlet -ctf term "Jika ada output seperti dibawah ini"
figlet -ctf term "Enter current password for root (enter for none):"
figlet -ctf term "maka tekan ENTER"
figlet -ctf term "jika ada pertanya Y/N maka di tekan Y dan tekan ENTER"
figlet -ctf term "di bagian setup password MySQL, masukkan password yang di inginkan sebanyak 2 kali, dengan password yang sama"
figlet -ctf term "step berikutnya ada 4 pertanya Y/N maka di tekan Y dan tekan ENTER"
mysql_secure_installation
systemctl restart mariadb
systemctl status nginx
systemctl status php-fpm
systemctl status mariadb
nginx -t
mv /usr/share/nginx/html/index.html /usr/share/nginx/html/index-original.html
wget https://raw.githubusercontent.com/NginxID/nginx-remi-repository-installer/master/index.html
mv index.html /usr/share/nginx/html/
wget https://sourceforge.net/projects/phpmyadmin/files/latest/download?source=files
yum -y install zip unzip
unzip download?source=files -d /usr/share/nginx/html
mv /usr/share/nginx/html/phpMyAdmin*all-languages /usr/share/nginx/html/e5946629d0ca8788d4ca5a1ba61074bd
mv /usr/share/nginx/html/e5946629d0ca8788d4ca5a1ba61074bd/config.sample.inc.php /usr/share/nginx/html/e5946629d0ca8788d4ca5a1ba61074bd/config.inc.php
sed -i 's/'cookie'/'http'/g' /usr/share/nginx/html/e5946629d0ca8788d4ca5a1ba61074bd/config.inc.php
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
