#!/bin/sh

if [ ! -f "/etc/vsftpd/vsftpd.conf.bak" ]; then

    mkdir -p /var/www/html

    cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
    mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf

    # Yeni kullanıcı ekle
    adduser $FTP_USR --disabled-password
    echo "$FTP_USR:$FTP_PWD" | /usr/sbin/chpasswd &> /dev/null
    # Dosya üzerindeki kullanıcı yetkisi
    chown -R $FTP_USR:$FTP_USR /var/www/html

    # env'den FTP_USR değerini alıp vsftpd.userlist dosyasına yazar
    echo $FTP_USR | tee -a /etc/vsftpd.userlist &> /dev/null

fi

# vsftpd başlat
echo "FTP started on :21"
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
