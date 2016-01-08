#!/bin/sh
# script to compile mysql4 for docker

#make data dir
mkdir -p /db /usr/local/src

#make and install mysql4

cd /usr/local/src/
tar -xvzf mysql-4.1.25.tar.gz
cd mysql-4.1.25/
./configure --prefix=/usr/local/mysql --localstatedir=/db
make && make install
cp support-files/my-medium.cnf /etc/my.cnf
make clean

#adopt rights
cd /usr/local/mysql/
chown -R root:mysql .
chown -R mysql:mysql /db


