#!/bin/bash

find /var/log/remote -type f -not -name '*.gz' -ctime +3 -exec gzip -9 {} \;

find /var/log/remote -type d -empty -delete
