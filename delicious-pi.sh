#!/usr/bin/env sh
# Alexis Megas.

while
    echo $(date '+%Y-%m-%d:%H:%M:%S:%N'; vcgencmd measure_temp) > \
	 data/pi-temperature.txt
    git commit -a -m "New data!"
    sleep 30
do true; done

exit 0
