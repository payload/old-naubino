package stat.es
{
	public class Lost extends GameState
	{
		
		public function Lost(game:Game) 
		{
			super(game);
		}
		
		public override function spam():void{}

		public override function refresh():void {}
		
		public override function pause():void {
			game.state = new Play(game);
			game.menu.setPlayButton();
			game.spammer.stop();
		}
		
	}

}
