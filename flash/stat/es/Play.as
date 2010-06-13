package stat.es
{
	public class Play extends GameState
	{
		
		public function Play(game:Game) 
		{
			super(game);
		}
		public override function spam():void{
			game.spammer.randomPair();
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
		
		public override function pause():void {
			game.state = new Pause(game);
			game.menu.setPlayButton();
		}
		
	}

}
