#!/bin/bash
crontab -l | grep "Tunnid" | tr -d '#'
