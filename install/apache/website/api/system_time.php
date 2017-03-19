<?php

$systemTime = shell_exec('date +%H:%M:%S');
$systemTime = trim($systemTime);
echo json_encode(array(
    'time' => $systemTime
));
?>
