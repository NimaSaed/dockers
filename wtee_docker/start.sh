#!/usr/bin/env sh
set -o nounset # Treat unset variables as an error

hostname=$(cat /etc/hostname)

if [ ${FILENAME:-nothing} = "nothing" ]; then
    echo "Wrong options"
    echo ""
    echo "Help:"
    echo "--------------------------------------------------------"
    echo "docker run --rm -d -p <your_port>:8080 -e FILENAME=<your_filename> -v <path/to/logfolder/>:/log nimasaed/wtee"
    exit 1;
else
    tail -F /log/${FILENAME} | /usr/bin/wtee -b $hostname:8080
fi
