package stat.es
{
	public class Credits extends GameState
	{
		
		public function Credits(game:Game) 
		{
			super(game);
		}
		
		public override function refresh():void {}
		
		public override function enter():void {
			trace("credits");
			game.visual.credits.show();
		}

		public override function leave():void {
			game.visual.credits.hide();
		}
		
	}
}
