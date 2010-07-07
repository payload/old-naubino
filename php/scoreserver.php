<?php
define("HIGHSCOREFILE","./score.txt");
define("SPLITTER","###");
define("JOINER","---");
define("MAX",10000);
define("LOGFILE", "./log");

class ScoreServer {
	public $name = "";
	public $points = "";
	public $heros = array();
	public $newby = false;
	private $log;

	public function ScoreServer(){

		$log = fopen(LOGFILE,"a+");
		fwrite($log, "start\n");

		//check whether the file is rw
		$this->diagnose();

		//loading heros from HIGHSCOREFILE
		$this->heros = $this->load_heros();

		fwrite($log, "heros: " . count($this->heros));
		
		//check for postdata
		if(isset($_POST['name']) && isset($_POST['points'])
		&& $_POST['name'] != "" && $_POST['points'] != ""){
			
			fwrite($log, "post: ".$_POST['name']." | ".$_POST['points']."\n");

			$this->name = $this->clean($_POST['name']);
			$this->points = $this->clean($_POST['points']);
			$this->newby = array($this->name,$this->points);
		}

		//store new file (overwritting all)
		if($this->newby){
			$this->add_hero($this->newby);
			$this->store_heros();
			$this->heros = $this->load_heros();

			fwrite($log, "heros: " . count($this->heros));

		}

		fwrite($log, "end\n");
		fclose($log);

	}
	
	public function load_heros($number = MAX){
		$fp = fopen(HIGHSCOREFILE,r);
		$heros = array();
		while(!feof($fp) && ($number == 0 || count($heros)<$number)){
			$temp = trim(fgets($fp));
			if($temp != "")
				array_push($heros, explode(SPLITTER,$temp));
		}
		fclose($fp);
		return $heros;
	}
	
	// adds hero to list without writing
	public function add_hero($newby){
		$notAdded = true;
		$newheros = array();
		if(!$this->contains($newby) && $newby[1] > 0){
			for($i=0;$i < count($this->heros);$i++){
				$hero = $this->heros[$i];
				if($notAdded && $hero[1] <= $newby[1]){
					array_push($newheros,$newby);
					$notAdded = false;
				}
				array_push($newheros,$hero);
			}
			if($notAdded)array_push($newheros,$newby);
			$this->heros =  $newheros;
		}
	}
	
	public function store_heros(){
		$fp = fopen(HIGHSCOREFILE,w);
		for($i=0;$i < count($this->heros);$i++){
			$hero = $this->heros[$i];
			fwrite($fp,$hero[0] . SPLITTER . $hero[1]."\n");
		}
		fclose($fp);
	}

	public function formated_heros(){
		echo "<table>\n";
		for($i=0;$i< count($this->heros);$i++){
			$hero = $this->heros[$i];
			echo "<tr><td>".$hero[0] ."</td><td>".$hero[1]."</td></tr>\n";
		}
		echo "</table>\n";
	}
	
	public function unformated_heros(){
		for($i=0;$i< count($this->heros);$i++){
			$hero = $this->heros[$i];
			echo $hero[0] . SPLITTER . $hero[1]."\n";
		}
	}
	
	public function string_heros(){
		for($i=0;$i< count($this->heros);$i++){
			if($i > 0)echo JOINER;
			$hero = $this->heros[$i];
			echo $hero[0] . SPLITTER . $hero[1];
		}
	}
	
	public function string_heros_backward(){
		for($i=count($this->heros)-1;$i>=0 ;$i--){
			$hero = $this->heros[$i];
			echo $hero[0] . SPLITTER . $hero[1];
			if($i > 0)echo JOINER;
		}
	}

	public function contains($newby){
			for($i = 0;$i < count($this->heros); $i++){
				$hero = $this->heros[$i];
				if($hero[0] == $newby[0]
				&& $hero[1] == $newby[1])
				return true;
			}
			return false;
	}
	
	public function clean($str){
		$str = str_ireplace(JOINER,"",$str);
		$str = str_ireplace(SPLITTER,"",$str);
		return $str;
	}

	public function diagnose(){
		if(!file_exists(HIGHSCOREFILE)){
			header( 'Content-Type: text/plain' );
			die("error###0");
		}
		if(!is_readable(HIGHSCOREFILE)){
			header( 'Content-Type: text/plain' );
			die("error###1");
		}
		if(!is_writable(HIGHSCOREFILE)){
			header( 'Content-Type: text/plain' );
			die("error###2");
		}
	}
}
?>
