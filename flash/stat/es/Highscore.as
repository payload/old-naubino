package stat.es 
{
	import flash.net.*;

	public class Highscore extends GameState
	{
		public var hallOfFame:Object; // used in Highscore and Visual

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
			hallOfFame = highscore;

			game.menu.mainbtn.setAction(function():void{ changeState(play); });
			
			//var submit:Button = newButton(Color.random, "submit", function(){ trace("hell yeah!"); });
			
			//game.visual.overlayNameField(submit);
			game.visual.overlayList(hallOfFame);
		}

		public override function leave():void {
			game.menu.mainbtn.setAction(function():void{ changeState(highscore); });
			game.visual.clearOverlay();
		}
		
		private function newButton(color:Color, str:String, action:Function=null):Button {
			var btn : Button = new Button();
			btn.color = color;
			if(action == null)
				btn.setAction(function():void{trace(str)});
			else
				btn.setAction(action);	
			btn.type = str;
			game.objs.push(btn);
			return btn;
		}
	}
}
