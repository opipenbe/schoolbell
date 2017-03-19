#!/bin/bash
crontab -l | grep -m 1 -oP  "/end.mp3 -volume \K.*"
