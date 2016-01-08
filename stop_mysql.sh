#!/bin/bash

if ls -1 /db/*.pid >/dev/null 2>&1; then
	kill $(cat /db/*.pid)
elif  ps -ef|grep "[m]ysqld" >/dev/null; then
	kill -9 $( ps -ef|grep "[m]ysqld"|awk '{print $1}')
else
	echo "No pid file, no process"
	goto end
fi
sleep 5
if ! ps -ef|grep "[m]ysqld" >/dev/null; then
	echo "Stop OK!"
else
	echo "Stop failed!" 
	ps -ef|grep "[m]ysqld"
fi
:end
fg 2>/dev/null