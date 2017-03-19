#!/bin/bash
new_vol_level=$1
WORK_DIR="/home/schoolbell/ding_conf/tables"
cur_vol_level=$(grep -m 1 -oP  "/end.mp3 -volume \K.*" $WORK_DIR/45MIN/45)
sed -i 's/end.mp3 -volume '$cur_vol_level'/end.mp3 -volume '$new_vol_level'/' $WORK_DIR/45MIN/45
cur_vol_level=$(grep -m 1 -oP  "/end.mp3 -volume \K.*" $WORK_DIR/35MIN/35)
sed -i 's/end.mp3 -volume '$cur_vol_level'/end.mp3 -volume '$new_vol_level'/' $WORK_DIR/35MIN/35
cur_vol_level=$(grep -m 1 -oP  "/end.mp3 -volume \K.*" $WORK_DIR/30MIN/30)
sed -i 's/end.mp3 -volume '$cur_vol_level'/end.mp3 -volume '$new_vol_level'/' $WORK_DIR/30MIN/30
crontab -u schoolbell $WORK_DIR/45MIN/45
