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
		}

		public override function leave():void {}
		
	}

}
