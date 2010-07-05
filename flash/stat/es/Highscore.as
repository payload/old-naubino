package stat.es 
{
	import flash.net.*;
	import flash.text.*;
    import flash.events.*;


	public class Highscore extends GameState
	{
		public	var hallOfFame:Array; // used in Highscore and Visual
		private var submit:Button;
		private var request:URLRequest;
		private var heros:URLLoader;
		public	var online:Boolean = true; //solve this via catching sandbox violations

		public function Highscore(game:Game) 
		{
			super(game);
			//cheatHighscore();
		}

		public override function enter():void {
		
			trace("highscore");
			updateHighscore();
			game.menu.mainbtn.setAction(function():void{ changeState(play); });
			//initForm();
		}

		public override function leave():void {
			game.menu.mainbtn.setAction(function():void{ changeState(highscore); });
			game.visual.highscore.hide();
			//game.visual.clearOverlay();
		}
		
		public function fetchScore():void{
		  try{
			 request = new URLRequest("score.php");
			 heros = new URLLoader();
			 heros.addEventListener(Event.COMPLETE, heroHandler);
			 heros.dataFormat = URLLoaderDataFormat.TEXT;
			 heros.load(request);
		  }
		  catch (e:Error)	{
			 trace("caught one");
		  }
		}
		
		private function heroHandler(e:Event):void{
		  try{
			game.states.highscore.hallOfFame = parseScore(heros.data);
			game.visual.highscore.show();
		  }
		  catch (e:Error){
		  }
		}
		
		private function parseScore(string:String):Array{
			var hallOfFame:Array = [];
			var lines:Array = string.split("---");
			var inline:Array;
			for(var i:uint = 0; i<lines.length; i++){
				var hero:Hero = new Hero();
				inline = lines[i].split("###");
				hero.name = inline[0];
				hero.points = inline[1];
				hallOfFame.push(hero);
			}
			return hallOfFame;
		}
		
		public function deleteHighscore():void{
				var obj:SharedObject = SharedObject.getLocal("highscore");
				obj.data.hallOfFame = [];
				obj.flush();
		}
		
		public function cheatHighscore():void{
				var obj:SharedObject = SharedObject.getLocal("highscore");
				obj.data.hallOfFame = [
				{name : "Hendrik", points : 200},
				{name : "Gilbert", points : 500},
				{name : "Alex", points : 23},
				{name : "Sten", points : 7},
				{name : "Thomas", points : 3}
				];
				obj.flush();
		}

		private function updateHighscore(insert:Object = null):void {
			var obj:SharedObject = SharedObject.getLocal("highscore");
			if(online){
				fetchScore();
			}
			else{
				if(obj.size != 0){
					hallOfFame = obj.data.hallOfFame;
				}
				else{
					hallOfFame = [];
					obj.data.hallOfFame = hallOfFame;
					obj.flush();
				}
				game.visual.highscore.show();
			}
		}
		
		
	}
}
