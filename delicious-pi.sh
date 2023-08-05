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
    mkdir -p data
    echo $(date '+%Y-%m-%d:%H:%M:%S:%N'; vcgencmd measure_temp) > \
	 data/pi-temperature-$ip_address.txt
    git add data 2>/dev/null
    git commit -m "New data ($ip_address)!" data
    git push https://${GIT_A}:${GIT_T}@github.com/textbrowser/heartbeat
    sleep 60
do true; done

exit 0
