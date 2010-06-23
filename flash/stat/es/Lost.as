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

		public function sendHighscore(name:String) {
			var url:String = "http://www1.inf.tu-dresden.de/~s8880935/naubino/score.php";
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
		}

		public override function leave():void {
			game.visual.lost.hide();
			game.lost = false;
			game.clear();
			game.points = 0;
		}
	}
}
