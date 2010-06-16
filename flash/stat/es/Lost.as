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
		}

		public override function leave():void {
			game.lost = false;
		}
	}
}
