#!/bin/bash
crontab -l | grep -m 1 -oP  "/start.mp3 -volume \K.*"
