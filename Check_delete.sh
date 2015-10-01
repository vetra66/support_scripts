## Script checks the size of the file and deletes it, if over a desired file size.

#!/bin/bash

file="test.txt"
maxsize=15    # 100 kilobytes
while true; do
    actualsize=$(du -k "$file" | cut -f1)
    if [ $actualsize -ge $maxsize ]; then
        echo size is over $maxsize kilobytes
        `rm -rf $file`
    exit
    else
        echo size is under $maxsize kilobytes
    fi

    sleep 1800 # in seconds = 30 minutes
done

