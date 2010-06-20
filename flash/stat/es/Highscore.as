package stat.es 
{
	import flash.net.*;
	import flash.text.*;
    import flash.events.*;


	public class Highscore extends GameState
	{
		public var hallOfFame:Object; // used in Highscore and Visual
		private var submit:Button;
		private var request:URLRequest;
		private var heros:URLLoader;
		private var online:Boolean = true; //solve this via catching sandbox violations

		public function Highscore(game:Game) 
		{
			super(game);
		}

		public override function enter():void {
		
			trace("highscore");
			
			updateHighscore();
			game.menu.mainbtn.setAction(function():void{ changeState(play); });
			game.visual.highscore.show();
			//initForm();
		}

		public override function leave():void {
			game.menu.mainbtn.setAction(function():void{ changeState(highscore); });
			game.visual.highscore.hide();
			//game.visual.clearOverlay();
		}
		
		public function fetchScore():String{
            try{
	            request = new URLRequest("http://www1.inf.tu-dresden.de/~s8880935/naubino/score.php");
	            heros = new URLLoader();
	            heros.addEventListener(Event.COMPLETE, heroHandler);
				heros.dataFormat = URLLoaderDataFormat.TEXT;
				heros.load(request);
            }
			catch (e:Error)	{
				trace("caught one");
				return "outch - Sandbox!";
			}
			return heros.data;
		}
		
		private function heroHandler(e:Event):void{
			try{
				hallOfFame = parseScore(heros.data);
				game.menu.playbtn.color = Color.black;
			}
			catch (e:Error){}
		}
		
		private function parseScore(string:String):Object{
			var object:Object = {};
			var lines:Array = string.split("---");
			var inline:Array;
			for(var i:uint = 0; i<lines.length; i++){
				inline = lines[i].split("###");
				object[inline[0]] = inline[1];
			}
			return object;
		}

		private function updateHighscore(insert:Object = null):void {
			var highscore:Object;
			if(online){
				fetchScore();
			}
			else{
				var obj:SharedObject = SharedObject.getLocal("highscore");
				if(insert == null)highscore = obj.data;
				else highscore = insert;
				if (obj.size == 0) {
					trace("new highscore");
					highscore["Alice"] = 100;
					highscore["Bob"] = 50;
					highscore["Claire"] = 80;
					highscore["Dave"] = 70;
					highscore["Lasmiranda De'Sivilia"] = 60;
					highscore["Eclaire"] = 32;
					highscore["Fred"] = 18;
					highscore["Gabi"] = 5;
				} else {
					trace("existing highscore");
				}
			}
			hallOfFame = highscore;
		}
		
		
	}
}
