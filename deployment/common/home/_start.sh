#!/bin/sh

PID_FILE=/home/engines/run/engines.pid	

export PID_FILE

if test -f /home/engines/functions/trap.sh 
 then
 . /home/engines/functions/trap.sh
 else
. /home/trap.sh
fi

. /home/engines/functions/start_functions.sh

volume_setup
dynamic_persistence

if test -f /home/_init.sh
 then
   /home/_init.sh
fi

first_run

restart_required

pre_running

custom_start


touch home/engines/run/flags/started_once

if ! test -z $exit_start
 then
  exit
fi   

#for non apache framework (or use custom start)
if test -f /home/engines/scripts/start/startwebapp.sh 
 then
   launch_app
elif test -f /usr/sbin/apache2ctl
 then

 export APACHE_PID_FILE=$PID_FILE
   start_apache
elif test -d /etc/nginx
 then
   start_nginx	
elif test -f /home/engines/scripts/blocking.sh 
  then
	 /home/engines/scripts/blocking.sh  &
	 echo -n " $!" >>  $PID_FILE		   
else
 echo "Nothing to run!"
fi

startup_complete
wait 
exit_code=$?
shutdown_complete
exit $exit_code
