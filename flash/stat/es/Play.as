package stat.es
{
	public class Play extends GameState
	{
		
		public function Play(game:Game) 
		{
			super(game);
		}

		public override function refresh():void {			//if (game.enablePhysics)
				game.physics.physik();
			game.antipoints = game.countingJoints();
			if (game.antipoints > game.ballsTillLost) {
				changeState(Lost);
			}
		}

		public override function enter():void {
			trace("play");
			game.menu.showPause();
			game.spammer.start();
		}

		public override function leave():void {
			game.spammer.stop();
			game.menu.showPlay();
		}
	}
}
