<?php
include("./scoreserver.php");

$s = new ScoreServer();

if($_GET['hackme']=="please"){
$s->formated_heros();
?>

<hr/>

<form action="<?php echo $PHP_SELF ?>" method="post">
<label for="name">Name</label>
<input type="text" name="name" id="name" value="<?php echo 'hendrik'/*$_POST['name']*/ ?>" /><br/>
<label for="points">Punkte</label>
<input type="text" name="points" id="points" value="<?php echo $_POST['points']+1 ?>" /><br/>

<input type="submit" />
</form>

<?php
}
elseif($_GET['type']=="rss"){

echo '<?xml version="1.0" encoding="UTF-8"?>';
 ?><rss version="2.0">

<channel>
<title>Naubino</title>
<link><?php echo $SELF_PHP ?></link>
<description>Highscore</description>
<language>de</language>

<?php
	for($i=0;$i<count($s->heros);$i++){
	?>
	<item>
		<title><?PHP echo $s->heros[$i][0] ." ".$s->heros[$i][1]?></title>
	</item>
	<?php
	}
?>
</channel>
</rss>


<?PHP
}
else{
header( 'Content-Type: text/plain' );
$s->string_heros_backward();

}
?>
