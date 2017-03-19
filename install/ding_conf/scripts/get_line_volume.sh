#!/bin/bash
amixer -c 0 -M get Line | awk '$0~/%/{print $5}' | tr -d '[%]' | head -1
