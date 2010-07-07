package stat.es
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.*;
	public class Lost extends GameState
	{
		
		public function Lost(game:Game) {
			super(game);
		}

		public function enterHallOfFame(name:String):void{
			if(game.states.highscore.online)
				sendHighscore(name);
			else
				storeHighscore(name);
		}
		private function alreadyIn(name:String):Boolean{
			var obj:SharedObject = SharedObject.getLocal("highscore");
			var hallOfFame:Array = obj.data.hallOfFame;
			for(var i:* in hallOfFame){
				if(hallOfFame[i].name == name && hallOfFame[i].points == game.points)
					return true;
			}
			return false;
		}

		private function storeHighscore(name:String):void{
			if(game.points > 0 && !alreadyIn(name)){
				var obj:SharedObject = SharedObject.getLocal("highscore");
				var hallOfFame:Array;
				var newby:Hero = new Hero();

				if(obj.size != 0)
					hallOfFame = obj.data.hallOfFame;
				else
					hallOfFame = [];

				newby.name = name;
				newby.points = game.points;
				hallOfFame.push(newby);
				obj.data.hallOfFame = hallOfFame;
				obj.flush();
			}
		}

		private function sendHighscore(name:String):void {
			var url:String = "score.php";
			var request:URLRequest = new URLRequest(url);
			var variables:URLVariables = new URLVariables();
			
			request.method = URLRequestMethod.POST;
			variables.name = name;
			variables.points = game.points;
			request.data = variables;
			
			var loader:URLLoader = new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, function(e:Event):void { leave(); } );
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			try {
                sendToURL(request);
            }
            catch (e:Error) {
                // handle error here
            }

		}
		
		public override function enter():void {
			trace("lost");
			game.lost = true;
			game.visual.lost.show();
			game.menu.playbtn.setAction(function():void {changeState(credits)});
			game.spammer.reset();
			//deleteHighscore();
		}

		public override function leave():void {
			game.visual.lost.hide();
			game.lost = false;
			game.clear();
			game.points = 0;
			game.menu.playbtn.setAction(function():void {changeState(play)});			
		}
	}
}
