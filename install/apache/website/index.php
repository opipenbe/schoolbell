<?php
/* DEBUG */
ini_set('display_errors', 'On');
error_reporting(E_ALL);

// TODO global variables: workDir, schoolbellUser

require_once("functions.php");

$page = "";
if (isset($_GET["page"])){
	$page = $_GET["page"];
}
switch ($page) {
  case 'alarm':
			show_alarm();
			break;
	case 'status':
			show_status();
			break;
  case 'system_time':
			show_system_time();
			break;
  case 'nextjob':
			show_nextjob();
			break;
  case 'table_state':
			show_table_state();
			break;
  case 'tables':
			show_tables();
			break;
  case 'operator':
			show_operator();
			break;
  case 'volume_settings':
  		show_volume_settings();
  		break;
	case 'line_in':
  		show_line_in();
  		break;
	case 'upload':
  		show_upload();
  		break;
	default:
		show_status();
		break;
}

?>
