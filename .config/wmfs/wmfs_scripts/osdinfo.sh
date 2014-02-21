#!/bin/bash
export DISPLAY=:0.0
checkcount=$(curl -s -u username:password https://mail.google.com/mail/feed/atom | grep '<fullcount>' | sed -e 's/<fullcount>//' -e 's/<\/fullcount>//')
rsscount=$(cat ~/.rsscount) # may need to be full path: /home/USERNAME/.rsscount#
date +"Month:%B Day:%d Time:%r" | aosd_cat -n "Serif 40" -f 500 -u 5000 -o 500 -p 7 -R purple && echo "Rss: $rsscount" | aosd_cat -n "Serif 40" -f 500 -u 3000 -o 500 -p 7 -R purple && echo "You have $checkcount new emails" | aosd_cat -n "Serif 40" -f 500 -u 3000 -o 500 -p 7 -R purple
