package stat.es
{
	public class Credits extends GameState
	{
		
		private var need_to_enter : Boolean;

		public function Credits(game:Game) 
		{
			super(game);
		}
		
		public override function refresh():void {
			if (need_to_enter) enter();
		}
		
		public override function enter():void {
			trace("credits");
			if (game.visual != null && game.visual.credits != null) {
				game.visual.credits.show();
				need_to_enter = false;
			}
			else
				need_to_enter = true;
		}

		public override function leave():void {
			game.visual.credits.hide();
		}
		
	}
}
