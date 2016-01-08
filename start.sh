#!/bin/bash
set -e
HOSTNAME=${HOSTNAME:-mysql4}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:mysql4}
if ! grep $HOSTNAME /etc/hosts >/dev/null; then
	echo "127.0.0.1 $HOSTNAME">> /etc/hosts
fi

if [ "$1" = 'mysqld_safe' ]; then
	chown -R mysql:mysql /db 
		
	if  ! ls -1 /db/* 1>/dev/null 2>&1 ; then
		echo "Initializing database..."
        	mysql_install_db --user=mysql 
       
		echo "Setting root password..."
		mysqld_safe --skip-networking &
		sleep 5
	
		#enable full network acess
		mysql -Uroot mysql <<-EOS
SET @@SESSION.SQL_LOG_BIN=0;
DELETE FROM user where host in ('localhost','$HOSTNAME');
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES ;
EOS
		sleep 5
		kill $(cat /db/*.pid)
		sleep 5
	fi
	
fi

#run it
if [ -n "$@" ]; then
	exec "$@"
fi

