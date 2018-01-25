#!/bin/sh

TAR=`which tar`
if [ -z "$TAR" ]; then
    echo "[!] To use this script you need to install util 'tar'\n Run: apt-get install tar OR yam install tar";
    exit 1
fi
CFTP=`which curlftpfs`
if [ -z "$CFTP" ]; then
    echo "[!] To use this script you need to install util 'curlftpfs'\n Run: apt-get install curlftpfs OR yam install curlftpfs";
    exit 1
fi
if [ ! -f /etc/codre-curlftpfs-backuper.cfg ]; then
    echo "File /etc/codre-curlftpfs-backuper.cfg not found!\nRun: sh /usr/share/codre-curlftpfs-backuper/config.sh";
fi

echo "$(date +%Y-%m-%d:%H:%M:%S) BACKUP START" >> /var/log/codre.curlftpfs.backuper.log;
source /etc/codre-curlftpfs-backuper.cfg;
date="$(date +%d_%m_%Y_%H)";
Fname="$(uname -n)";

curlftpfs $Suser:$Spass@$Suser.$Shost /mnt/$Sdir/ >> /var/log/codre.curlftpfs.backuper.log;

mkdir -p $doc_root/$date;
cd $doc_root/$date;

blacklist=(Database information_schema performance_schema mysql phpmyadmin pma sys);

for dbname in `echo "show databases;" | mysql -u$username -p$password`; do
	if [[ ${blacklist[*]} =~ $dbname  ]] 
	then
		echo "mysql:skip $dbname" >> /var/log/codre.curlftpfs.backuper.log;
	else
		mysqldump -h$host -u$username -p$password $dbname > $dbname.sql &&
		sudo tar -czf $dbname.tar.gz $dbname.sql && rm $dbname.sql
		mkdir -p /mnt/$Sdir/$Fname/$date/db/
		mv $doc_root/$date/$dbname.tar.gz /mnt/$Sdir/$Fname/$date/db/
		echo "mysql:$date.tar.gz" >> /var/log/codre.curlftpfs.backuper.log;
	fi
done

cd $doc_root;

rm -Rf $doc_root/$date/

echo "mysql:Done." >> /var/log/codre.curlftpfs.backuper.log;

mkdir -p $doc_root/$date;

cd $site_root
blacklist=(vsftpd/ phpmyadmin/)

for sitename in `ls -d -- */`; do
	if [[ ${blacklist[*]} =~ $sitename ]] 
	then
		echo "file:skip $sitename" >> /var/log/codre.curlftpfs.backuper.log;
	else
		mkdir -p /mnt/$Sdir/$Fname/$date/files/
		sudo tar -cjf /mnt/$Sdir/$Fname/$date/files/${sitename%/}.tar.bz2 $sitename
		echo "file: ${sitename%/}.tar.bz2" >> /var/log/codre.curlftpfs.backuper.log;		
	fi
done
echo "files:Done." >> /var/log/codre.curlftpfs.backuper.log;

cd /;
mkdir -p /mnt/$Sdir/$Fname/$date/system/
sudo tar -cjf /mnt/$Sdir/$Fname/$date/system/etc.tar.bz2 /etc/
		echo "system: etc" >> /var/log/codre.curlftpfs.backuper.log;
sudo tar -cjf /mnt/$Sdir/$Fname/$date/system/usr.tar.bz2 /usr/
		echo "system: usr" >> /var/log/codre.curlftpfs.backuper.log;
sudo tar -cjf /mnt/$Sdir/$Fname/$date/system/var.tar.bz2 /var/
		echo "system: var" >> /var/log/codre.curlftpfs.backuper.log;
echo "system:Done." >> /var/log/codre.curlftpfs.backuper.log;

if [[ $Sdays > 0 ]]
then
	cd /mnt/$Sdir/$Fname/;
	find /mnt/$Sdir/$Fname/* -type d -mtime +$Sdays  -exec rm -rf {} \;
	echo "clean:Done." >> /var/log/codre.curlftpfs.backuper.log;
fi;

echo "$(date +%Y-%m-%d:%H:%M:%S) BACKUP END" >> /var/log/codre.curlftpfs.backuper.log;