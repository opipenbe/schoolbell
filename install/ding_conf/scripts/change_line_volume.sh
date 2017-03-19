#!/bin/bash
amixer -c 0 -M set Line 0 > /dev/null 2>&1
amixer -c 0 -M set Line $1%+ > /dev/null 2>&1
