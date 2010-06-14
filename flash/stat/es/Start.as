package stat.es
{
	public class Start extends GameState
	{
		
		public function Start(game:Game) 
		{
			super(game);
		}
		
		public override function play():void {
			game.state = new Play(game);
		}
	}
}