#!/usr/bin/env sh
# Alexis Megas.

if [ -z ${GIT_A} ];
then
    echo "Please export GIT_A."
    exit 1
fi

if [ -z ${GIT_T} ];
then
    echo "Please export GIT_T."
    exit 1
fi

while
    ip_address=$(hostname -I | head -1 | tr --delete " \n")

    if [ -z "$ip_address" ];
    then
	ip_address="127.0.0.1"
    fi

    mkdir -p data
    echo $(date '+%Y-%m-%d:%H:%M:%S:%N') > \
         data/pi-netstat-$ip_address.txt
    netstat -i >> data/pi-netstat-$ip_address.txt
    echo $(date '+%Y-%m-%d:%H:%M:%S:%N') > \
         data/pi-uptime-$ip_address.txt
    uptime >> data/pi-uptime-$ip_address.txt
    echo $(date '+%Y-%m-%d:%H:%M:%S:%N'; vcgencmd measure_temp) > \
	 data/pi-temperature-$ip_address.txt
    git pull
    git add data 2>/dev/null
    git commit -m "New data ($ip_address)!" data
    git push https://${GIT_A}:${GIT_T}@github.com/textbrowser/heartbeat
    sleep 300
do true; done

exit 0
