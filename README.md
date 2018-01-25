What is ``curlftpfs-backup.sh``?
--------------------

It's a simple script for backup site to cloud storage based on
`curlftpfs`.

Installation
------------

For using the script you need installed utilities ``curlftpfs``, ``curl``, ``file`` and ``tar``.
Install for debian/ubuntu::

    $ apt-get install curl file tar curlftpfs

Get installing script::

    $ wget https://raw.githubusercontent.com/Codre/curlftpfs-backup.sh/master/install.sh && sh install.sh
    # or
    $ curl -Ok https://raw.githubusercontent.com/Codre/curlftpfs-backup.sh/master/install.sh && sh install.sh

Install manually::

    $ mkdir /usr/share/codre-curlftpfs-backuper/;
    $ cd /usr/share/codre-curlftpfs-backuper/;
    $ wget https://raw.githubusercontent.com/Codre/curlftpfs-backup.sh/master/config.sh && chmod +x config.sh;
    $ wget https://raw.githubusercontent.com/Codre/curlftpfs-backup.sh/master/backup.sh && chmod +x backup.sh;
    $ sh config.sh;
    
Usage
-----

Start backup::

    $ bash /usr/share/codre-curlftpfs-backuper/backup.sh;
    
Change configuration file::

    $ sh /usr/share/codre-curlftpfs-backuper/config.sh;
    
Show log file::

    cat /var/log/codre.curlftpfs.backuper.log;
