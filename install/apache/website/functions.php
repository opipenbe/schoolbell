<?php

function show_alarm(){
        include_once('view/head.html');
        include ("view/alarm.html");
        include_once('view/foot.html');
}

function show_status(){
        include_once('view/head.html');
        include ("view/status.html");
        include_once('view/foot.html');
}

function show_system_time(){
        include ("api/system_time.php");
}

function show_nextjob(){
        include ("api/nextjob.php");
}

function show_table_state(){
        include ("api/table_state.php");
}

function show_tables(){
        include_once('view/head.html');
        include ("view/tables.html");
        include_once('view/foot.html');
}

function show_operator(){
        include_once('view/head.html');
        include ("view/operator.html");
        include_once('view/foot.html');
}

function show_volume_settings(){
        include_once('view/head.html');
        include ("view/volume_settings.html");
        include_once('view/foot.html');
}

function show_upload(){
        include_once('view/head.html');
        include ("api/upload.php");
        include_once('view/foot.html');
}

function show_line_in(){
        include ("api/line_in.php");
}
?>
