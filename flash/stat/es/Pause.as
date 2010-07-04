package stat.es
{
	public class Pause extends GameState
	{
		
		public function Pause(game:Game) 
		{
			super(game);
		}
		
		public override function refresh():void {}
		
		public override function enter():void {
			trace("pause");
			game.visual.pause.show();
			game.jukebox.play();
		}

		public override function leave():void {
			game.visual.pause.hide();
			game.jukebox.pause();
		}
		
	}
}
