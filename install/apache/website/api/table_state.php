<?php
  $schoolbellUser = exec("whoami");
  $workDir = "/home/$schoolbellUser/ding_conf";
  $state = exec("sh $workDir/scripts/check_state.sh 2>&1");
  echo json_encode(array(
      'table_state' => $state
  ));
?>
