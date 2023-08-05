#!/usr/bin/env sh
# Alexis Megas.

while
    mkdir -p data
    echo $(date '+%Y-%m-%d:%H:%M:%S:%N'; vcgencmd measure_temp) > \
	 data/pi-temperature-$(hostname -I | head -1 | tr --delete ' \n').txt
    git add data 2>/dev/null
    git commit -m "New data!" data
    git push https://${GIT_A}:${GIT_T}@github.com/textbrowser/heartbeat
    sleep 30
do true; done

exit 0
