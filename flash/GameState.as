package 
{
	public class GameState
	{
		protected var game:Game;
		public var state:GameState;
		
		public function GameState(game:Game) {
			this.game = game;
		}
		
		public function refresh():void {
			
		}

	}
	
}