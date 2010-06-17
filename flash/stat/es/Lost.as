package stat.es
{
	public class Lost extends GameState
	{
		
		public function Lost(game:Game) {
			super(game);
		}

		public override function enter():void {
			trace("lost");
			game.lost = true;
			game.visual.overlayLost();
			game.menu.playbtn.setAction(function():void{ game.menu.exitAction(); 
				changeState(start);  });//not so nice, but works
		}

		public override function leave():void {
			game.visual.clearOverlay();
			game.lost = false;
			
		}
	}
}
