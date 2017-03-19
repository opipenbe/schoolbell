<?php
  $schoolbellUser = exec("whoami");
  $workDir = "/home/$schoolbellUser/ding_conf";
  $state = exec("bash $workDir/scripts/get_line_state.sh 2>&1");
  echo json_encode(array(
      'state' => $state
  ));
?>
