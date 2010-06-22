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
else{
header( 'Content-Type: text/plain' );
$s->string_heros_backward();

}
?>
