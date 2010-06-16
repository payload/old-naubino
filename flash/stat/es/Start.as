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
			game.menu.mainbtn.setAction(function():void{ changeState(Highscore); });

			changeState(Play);
		}
	}
}