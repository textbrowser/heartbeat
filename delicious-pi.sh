#!/usr/bin/env sh
# Alexis Megas.

while
    echo $(date '+%Y-%m-%d:%H:%M:%S:%N'; vcgencmd measure_temp) > \
	 data/pi-temperature-$(hostname -I).txt
    git add data 2>/dev/null
    git commit -a -m "New data!"
    git push https://${GIT-A}:${GIT-T}@github.com/textbrowser/heartbeat
    sleep 30
do true; done

exit 0
