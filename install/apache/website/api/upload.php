<?php //upload

if ($_FILES["file"]["error"] > 0) {
  echo "Viga: " . $_FILES["file"]["error"] . "<br>";
} else {
    echo "<br><b>Valitud fail on edukalt salvestatud!</b></br>";
    echo "Suurus: " . ($_FILES["file"]["size"] / 1024) . " kB<br>";
}

$schoolbellUser = exec("whoami");

move_uploaded_file($_FILES["file"]["tmp_name"],"/home/schoolbell/ding_conf/melodies/" . $_FILES["file"]["name"]);
echo "Helifailide asukoht: " . "/home/$schoolbellUser/ding_conf/melodies/" . $_FILES["file"]["name"];

?>
<br>
<FORM><INPUT Type="button" VALUE="Pöördu tagasi seadustuste juurde" onClick="history.go(-1);return true;"></FORM>
</br>
