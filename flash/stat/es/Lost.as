package stat.es
{
	public class Lost extends GameState
	{
		
		public function Lost(game:Game) {
			super(game);
		}

		public override function enter():void {
			trace("lost");
			game.lost = true;
			game.visual.overlayLost();
		}

		public override function leave():void {
			game.lost = false;
		}
	}
}
