package stat.es
{
	public class Play extends GameState
	{
		
		public function Play(game:Game) 
		{
			super(game);
		}

		public override function refresh():void {		
			game.physics.physik();
			game.antipoints = game.countingJoints();
			game.warn();
			if (game.antipoints > game.ballsTillLost) {
				changeState(lost);
			}
		}

		public override function enter():void {
			trace("play");
			game.spammer.start();
			showPauseButton();
			game.menu.helpbtn.setAction(function():void { changeState(game.states.help) });

			game.jukebox.play();
		}

		public override function leave():void {
			game.spammer.stop();
			game.visual.stopAlert();
			showPlayButton();

			game.jukebox.pause();
		}		
	}
}
