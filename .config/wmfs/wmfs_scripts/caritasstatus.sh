#!/bin/bash
#colors
clear="#1793d1"
grey="#7D7D7D"
default="#222222"
green="#4E9A06"
lightgreen="#6DDD00"
dark="#1A1A1A"
dblue="#1874cd"
blue="#63b8ff"
red="#CC0000"
orange="#FFB000"
orangee="#F6A03A"
purple="#8E00FF"
net_interface="wlan0"
#net_interface="enp0s7"

mocpctrl(){
    echo "^s[90;9;$grey;mocp](1;spawn;urxvtc -e mocp) ^R[125;1;16;10;$dark]^s[126;10;$lightgreen;<<](1;spawn;mocp -r) ^R[142;1;24;10;$dark]^s[150;10;$lightgreen;>I](1;spawn;mocp -p) ^R[167;1;16;10;$dark]^s[168;10;$lightgreen;>>](1;spawn;mocp -f) ^R[184;1;16;10;$dark]^s[188;9;$lightgreen;II](1;spawn;mocp -G)"
}

home(){
    home="$(df -h|grep sda4|awk '{print $5}')"
    echo "^s[left;$orangee;$home]"
}

root(){
    root="$(df -h|grep sda3|awk '{print $5}')"
    echo "^s[left;$orangee;$root]"
}

volume(){
    volume="$(pactl list sinks | awk '/Volume: 0:/ {print substr($3, 1, index($3, "%") - 1)}')"
    echo "^s[left;$grey;$volume]"
}

mute(){
    mute="$(pacmd list-sinks 0 | grep muted | cut -d ' ' -f 2)"
    echo "^s[left;$grey;$mute]"
}

ttime(){
    ttime="$(date +"%B %d %r")"
    echo "^s[left;$orangee;$ttime]"
}

# mem section
memu(){
    memu="$(free -m | sed -n 's|^-.*:[ \t]*\([0-9]*\) .*|\1|gp')"
          if (( $memu >= 1000 ));then
color="$red"
          else
color="$green"
          fi

echo "^s[right;$clear;mem ]^s[right;$color;$memu]"
}
memt(){
    memt="$(free -m | sed -n 's|^M.*:[ \t]*\([0-9]*\) .*|\1|gp')"
    echo "^s[right;$purple;/$memt ]"
}

# cpu section
cpu(){
    cpu="$(eval $(awk '/^cpu /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat); sleep 0.4;
eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat);
intervaltotal=$((total-${prevtotal:-0}));
echo "$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))")"
          if (( $cpu >= 70 ));then
color="$red"
          else
color="$green"
          fi

echo "^s[right;$clear;cpu ]^s[right;$color;$cpu% ](1;spawn;urxvt -e htop)"
}

netup(){
    netup="$("$HOME/.config/wmfs/scripts/speed-wmfs.sh")"
    echo "^s[left;$clear; net ] ^s[left;$purple;${netup}]"
}

battery(){
    b1=`acpi -V | awk '{ gsub(/,/, "");} NR==1 {print $4}'`
        b2=`acpi -b | grep "Battery" | awk '{print $5}' | cut -c 1-2`
            b3=`acpi -b | grep "Battery" | awk '{print $5}' | cut -c 4-5`
                echo "^s[left;$clear; battery ] ^s[left;$purple;${b1} ${b2}:${b3}]"
}

# Might need to provide full path
email(){
    mail="$(cat ~/.emailstatus)"
    if [ -z "$mail" ]; then
echo "^s[left;$clear; mail ] ^s[left;$red;no new]"
    else
if [ $mail != 0 ]; then
echo "^s[left;$clear; mail ] ^s[left;$green;${mail} new]"
    fi
fi
}

# Might require full path
rss(){
    rss="$(cat ~/.rsscount)"
    if [ -z "$rss" ]; then
echo "^s[left;$clear; rss ] ^s[left;$red;no new]"
    else
echo "^s[left;$clear; rss ] ^s[left;$green;new]"
      fi

}

TIMING=1

#Might require full paths 
statustext()
{
wmfs -c status "marsbar 
^s[left;$orange; ToDo](1;spawn;urxvtc -T editor -e vim ~/Documents/.ToDo.txt)\
^s[left;$dblue; ThePad](1;spawn;urxvtc -T editor -e vim ~/Documents/.PostIt.txt)\
^s[left;$green; VIm](1;spawn;urxvtc -T editor -e vim)\
^s[left;$green; WWW](1;spawn;firefox)\
^s[left;$grey; IRC](1;spawn;urxvtc -T irc -e weechat-curses)\
^s[left;$grey; rFm](1;spawn;urxvtc -e ranger)\
^s[left;$grey; Git](1;spawn;urxvtc -e ranger ~/Github/)\
^s[left;\#445544; | ]\
^s[left;$clear;/ ]$(root)\
^s[left;$clear; home ]$(home)\
$(netup)\ $(email)\
^s[left;$clear; time ]$(ttime)(1;spawn;~/.config/wmfs/wmfs_scripts/dzen_calendar.sh)\ $(battery)\
$(cpu)\ $(memu)\ $(memt)\
^s[left;$clear; mocp](1;spawn;urxvtc -e mocp) ^s[left;$lightgreen;·<<·](1;spawn;mocp -r) ^s[left;$lightgreen;>·](1;spawn;mocp -p) ^s[left;$lightgreen;>>·](1;spawn;mocp -f) ^s[left;$lightgreen;||](1;spawn;mocp -G)]
"
}

while true;
do
statustext
    sleep $TIMING
done
