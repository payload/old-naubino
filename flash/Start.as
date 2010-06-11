package  
{
	public class Start extends GameState
	{
		
		public function Start(game:Game) 
		{
			super(game);
		}
		

		public override function refresh():void {
			if (game.enablePhysics)
				game.physics.physik();
			game.antipoints = game.countingJoints();
			if (game.antipoints > game.ballsTillLost) {
				game.lost = true;
				game.clear();
				game.useGenerateTimer = false;
			}
		}
		
	}

}