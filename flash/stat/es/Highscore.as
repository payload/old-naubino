package stat.es 
{
	import flash.net.*;

	public class Highscore extends GameState
	{
		public function Highscore(game:Game) 
		{
			super(game);
		}

		public override function enter():void {
			trace("highscore");

			var obj:SharedObject = SharedObject.getLocal("highscore");
			var highscore:Object = obj.data;
			if (obj.size == 0) {
				trace("new highscore");
				highscore["Alice"] = 100;
				highscore["Bob"] = 50;
				highscore["Claire"] = 80;
				highscore["Dave"] = 70;
				highscore["Lasmiranda De'Sivilia"] = 60;
			} else {
				trace("existing highscore");
			}
			game.highscore = highscore;

			game.menu.mainbtn.setAction(function():void{ changeState(play); });
		}

		public override function leave():void {
			game.menu.mainbtn.setAction(function():void{ changeState(highscore); });
		}
	}
}
