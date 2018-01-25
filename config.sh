#!/bin/sh

doc_root=/tmp/;
echo "\nSITES DIR:"
read site_root;
echo "\nMySQL HOST:";
read host;
echo "\nMySQL ROOT USER:";
read username;
echo "\nMySQL ROOT PASSWORD:";
read password;
echo "\nStorage host:";
read Shost;
echo "\nStorage login:";
read Suser;
echo "\nStorage password:";
read Spass;
echo "\nStorage dir name:";
read Sdir;
echo "\nSave backup days:";
read Sdays;

echo "doc_root=\"$doc_root\";\nsite_root=\"$site_root\";\nhost=\"$host\";\nusername=\"$username\";\npassword=\"$password\";\nShost=\"$Shost\";\nSuser=\"$Suser\";\nSpass=\"$Spass\";\nSdir=\"$Sdir\";\Sdays=\"$Sdays\";" > /etc/codre-curlftpfs-backuper.cfg;
echo "\nConfig save!";