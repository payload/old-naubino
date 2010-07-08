<?php
define("HIGHSCOREFILE","./score.txt");
define("SPLITTER","###");
define("JOINER","---");
define("MAX",10000);
define("MAXSHOW",5);
define("LOGFILE", "./log");

class ScoreServer {
	public $name = "";
	public $points = "";
	public $heros = array();
	public $heros_exclusive = array();
	public $newby = false;
	private $log;

	public function ScoreServer(){

		//check whether the file is rw
		$this->diagnose();

		//loading heros from HIGHSCOREFILE
		$this->heros = $this->load_heros(); //used in writing
		$this->heros_exclusive = $this->load_heros_exclusive(); //only use to display

	}
	
	public function start_log(){
		$this->log = fopen(LOGFILE,"a+");
		fwrite($this->log, "start\n");
		fwrite($this->log, "heros: " . count($this->heros));
	}

	public function end_log(){
		fwrite($this->log, "end\n");
		fclose($this->log);
	}
	
	// evaluate post data
	public function read_post()
	{
		if(isset($_POST['name']) && isset($_POST['points'])
		&& $_POST['name'] != "" && $_POST['points'] != ""){
			
			fwrite($this->log, "post: ".$_POST['name']." | ".$_POST['points']."\n");

			$this->name = $this->clean($_POST['name']);
			$this->points = $this->clean($_POST['points']);
			$this->newby = array($this->name,$this->points);
			return true;
		}
		else
			return false;
	}
	
	// write to file
	public function write()
	{
		//store new file (overwritting all)
		if($this->newby){
			$this->add_hero($this->newby);
			$this->store_heros();
			$this->heros = $this->load_heros();

			fwrite($this->log, "heros: " . count($this->heros));
			return true;
		}
		else
			return false;
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
	


	//loads highscorefile
	public function load_heros($number = MAX){
		$fp = fopen(HIGHSCOREFILE,r);
		$heros = array();
		while(!feof($fp) && ($number == 0 || count($heros)<$number)){
			$temp = trim(fgets($fp));
			if($temp != ""){
				$hero = explode(SPLITTER,$temp);
				array_push($heros, $hero);
			}
		}
		fclose($fp);
		return $heros;
	}
	
	//loads highscorefile - each name only once
	public function load_heros_exclusive($number = MAX){
		$fp = fopen(HIGHSCOREFILE,r);
		$heros = array();
		$namelist = array();
		while(!feof($fp) && ($number == 0 || count($heros)<$number)){
			$temp = trim(fgets($fp));
			if($temp != ""){
				$hero = explode(SPLITTER,$temp);
				if(!in_array($hero[0],$namelist)){
					array_push($namelist, $hero[0]);
					array_push($heros, $hero);
				}
			}
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
	
	// overwrite highscorefile with new list
	public function store_heros(){
		$fp = fopen(HIGHSCOREFILE,"w+");
		for($i=0;$i < count($this->heros);$i++){
			$hero = $this->heros[$i];
			fwrite($fp,$hero[0] . SPLITTER . $hero[1]."\n");
		}
		fclose($fp);
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

}
?>
