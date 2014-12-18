# Nginx Remi Repository Installer

#### Syarat

   * CentOS 5 (i386, x86_64)
   * CentOS 6 (i386, x86_64)
   * CentOS 7 (x86_64)
   * Harus OS bersih

#### Install

   * CentOS 5 (i386, x86_64)

> Masukan 1 perintah di bawah ini

```sh
wget https://raw.githubusercontent.com/NginxID/nginx-remi-repository-installer/master/centos5.sh && chmod u+x centos5.sh && ./centos5.sh
```
   * CentOS 6 (i386, x86_64)

> Masukan 1 perintah di bawah ini

```sh
wget https://raw.githubusercontent.com/NginxID/nginx-remi-repository-installer/master/centos6.sh && chmod u+x centos6.sh && ./centos6.sh
```
   * CentOS 7 (x86_64)

> Masukan 1 perintah di bawah ini

```sh
wget https://raw.githubusercontent.com/NginxID/nginx-remi-repository-installer/master/centos7.sh && chmod u+x centos7.sh && ./centos7.sh
```

#### Alternatif

> Gunakan __install5_6.sh__ di repository ini.
##### Syaratnya:
- CentOS 5 (i386, x86_64)
- CentOS 6 (i386, x86_64)

##### Apakah anda ingin menggunakan __install5_6.sh__? Ya.

> Masukan 1 perintah di bawah ini
```sh
wget https://raw.githubusercontent.com/NginxID/nginx-remi-repository-installer/master/install5_6.sh && chmod u+x install5_6.sh && ./install5_6.sh
```

-----

#### Note

Jika terjadi seperti ini

```sh
Resolving raw.githubusercontent.com... 23.235.39.133
Connecting to raw.githubusercontent.com|23.235.39.133|:443... connected.
ERROR: certificate common name “www.github.com” doesn’t match requested host name “raw.githubusercontent.com”.
To connect to raw.githubusercontent.com insecurely, use ‘--no-check-certificate’.
```

Maka update terlebih dahulu paket wget kalian, caranya

```sh
yum -y update wget
```

Atau saat memasukkan perintah

```sh
wget bla...bla...bla...
```

di tambahkan dengan

```sh
--no-check-certificate
```

sesudah __wget__

sebagai contoh

```sh
wget --no-check-certificate https://raw.githubusercontent.com/NginxID/nginx-remi-repository-installer/master/centos5.sh && chmod u+x centos5.sh && ./centos5.sh
```

#### License
__MIT__