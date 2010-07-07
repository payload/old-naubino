<?php

class ScoreOutput{
	
	public $heros = array();
	
	public function ScoreOutput($heros){
		$this->heros = $heros;
	}

	// all kinds of output

	public function heros_formated(){
		echo "<table>\n";
		for($i=0;$i< count($this->heros);$i++){
			$hero = $this->heros[$i];
			echo "<tr><td>".$hero[0] ."</td><td>".$hero[1]."</td></tr>\n";
		}
		echo "</table>\n";
	}
	
	public function heros_unformated(){
		for($i=0;$i< count($this->heros);$i++){
			$hero = $this->heros[$i];
			echo $hero[0] . SPLITTER . $hero[1]."\n";
		}
	}
	
	public function heros_string(){
		for($i=0;$i< count($this->heros);$i++){
			if($i > 0)echo JOINER;
			$hero = $this->heros[$i];
			echo $hero[0] . SPLITTER . $hero[1];
		}
	}
	
	public function heros_string_backward(){
		for($i=count($this->heros)-1;$i>=0 ;$i--){
			$hero = $this->heros[$i];
			echo $hero[0] . SPLITTER . $hero[1];
			if($i > 0)echo JOINER;
		}
	}
	public function rss_out(){
		echo '<?xml version="1.0" encoding="UTF-8"?>';
		?><rss version="2.0">

		<channel>
		<title>Naubino</title>
		<link><?php echo $PHP_SELF ?></link>
		<description>Highscore</description>
		<language>de</language>
		<?php
			for($i=0;$i<count($this->heros);$i++){
			?>
		<item>
			<title><?PHP echo $this->heros[$i][0] ." ".$this->heros[$i][1]?></title>
		</item>
			<?php
			}
		?>
		</channel>
		</rss><?PHP
	}

}

?>
