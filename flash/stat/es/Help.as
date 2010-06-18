package stat.es 
{
	public class Help extends GameState
	{
		
		public function Help(game:Game) 
		{
			super(game);
		}

		public override function enter():void {
			game.visual.help.show();
		}

		public override function leave():void {
			game.visual.help.hide();
		}
	}
}
