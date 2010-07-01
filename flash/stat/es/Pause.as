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
			game.naubino.chanPosition = game.naubino.chan.position;
			game.naubino.chan.stop();
		}

		public override function leave():void {
			game.visual.pause.hide();
			game.naubino.chan = game.naubino.globalSound.play(game.naubino.chanPosition);
		}
		
	}
}
