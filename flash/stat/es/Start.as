package stat.es
{
	public class Start extends GameState
	{
		
		public function Start(game:Game) 
		{
			super(game);
		}
		
		public override function enter():void {
			trace("start");
			showPlayButton();
			game.menu.mainbtn.setAction(function():void{ changeState(highscore); });
			changeState(credits);
		}
	}
}
