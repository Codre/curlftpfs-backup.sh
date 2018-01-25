#!/bin/sh
mkdir /usr/share/codre-curlftpfs-backuper/;
cd /usr/share/codre-curlftpfs-backuper/;
wget https://raw.githubusercontent.com/Codre/curlftpfs-backup.sh/master/config.sh && chmod +x config.sh;
wget https://raw.githubusercontent.com/Codre/curlftpfs-backup.sh/master/backup.sh && chmod +x backup.sh;
sh config.sh;
