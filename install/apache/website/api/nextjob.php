<?php
$nextJob = shell_exec('python /home/schoolbell/ding_conf/cronjob-predictor/cronjob_predictor.py -user schoolbell');
$nextJob = trim($nextJob);
echo json_encode(array(
    'job' => $nextJob
));
?>
