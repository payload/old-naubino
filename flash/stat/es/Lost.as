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
