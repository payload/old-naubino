﻿package stat.es
{
	public class Pause extends GameState
	{
		
		public function Pause(game:Game) 
		{
			super(game);
		}
		
		public override function spam():void{}

		public override function refresh():void {}
		
		public override function pause():void {
			game.state = new Play(game);
			game.menu.setPlayButton();
			game.spammer.stop();
		}
		
	}

}
