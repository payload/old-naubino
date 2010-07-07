<?php
include("./ScoreServer.php");
include("./ScoreOutput.php");
include("./utils.php");

$server = new ScoreServer();
$server->start_log();
if($server->read_post()){
	$server->write();
}
$server->end_log();


// select between full or exclusice highscore
if($_GET['showall']=="true")
	$output = new ScoreOutput($server->heros);
else
	$output = new ScoreOutput($server->heros_exclusive);


// test/cheat interface
if($_GET['hackme']=="please"){
	form();
	$output2 = new ScoreOutput($server->heros);
	$output2->heros_formated();
}

// rss feed
elseif($_GET['type']=="rss"){
	$output->rss_out();
}

// string for flash
else{
	header( 'Content-Type: text/plain' );
	$output->heros_string_backward();
//	echo "\n";
//	$s->heros_string_backward();
}



?>
