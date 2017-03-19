#!/bin/bash
/usr/bin/amixer -c 0 set 'Master' unmute /dev/null 2>&1
/usr/bin/amixer -c 0 set 'Headphone' unmute /dev/null 2>&1
/usr/bin/amixer -c 0 set 'Speaker' unmute /dev/null 2>&1
/usr/bin/amixer -c 0 set 'PCM' unmute /dev/null 2>&1


/usr/bin/amixer -c 0 set 'Master' 80% /dev/null 2>&1
/usr/bin/amixer -c 0 set 'Headphone' 80% /dev/null 2>&1
/usr/bin/amixer -c 0 set 'Speaker' 80% /dev/null 2>&1
/usr/bin/amixer -c 0 set 'PCM' 80% /dev/null 2>&1

