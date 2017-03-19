<html>
<meta charset="utf-8" />
<?php //upload
if ($_FILES["file"]["error"] > 0) {
  echo "Viga: " . $_FILES["file"]["error"] . "<br>";
} else {
    echo "<br><b><font color='red'>Valitud fail on edukalt salvestatud!</font></b></br>";
  //echo "Upload: " . $_FILES["file"]["name"] . "<br>";
  //echo "Type: " . $_FILES["file"]["type"] . "<br>";
  echo "Suurus: " . ($_FILES["file"]["size"] / 1024) . " kB<br>";
  //echo "Stored in: " . $_FILES["file"]["tmp_name"];
}


$kasutaja = exec("whoami"); //kes on kasutaja?


if (file_exists("/home/$kasutaja/Koolikell/Helinad/" . $_FILES["file"]["name"])) { //save
	move_uploaded_file($_FILES["file"]["tmp_name"],"/home/schoolbell/ding_conf/melodies/" . $_FILES["file"]["name"]);
	echo "Helifailide asukoht: " . "/home/schoolbell/ding_conf/melodies/" . $_FILES["file"]["name"];




	} else {
		move_uploaded_file($_FILES["file"]["tmp_name"],"/home/schoolbell/ding_conf/melodies/" . $_FILES["file"]["name"]);
		echo "Helifailide asukoht: " . "/home/schoolbell/ding_conf/melodies/" . $_FILES["file"]["name"];
	}

?>
<br>
<FORM><INPUT Type="button" VALUE="Pöördu tagasi esilehele" onClick="history.go(-1);return true;"></FORM>
</br>
</html>
