package stat.es
{ 
	public class GameState
	{
		protected var game:Game;

		public function GameState(game:Game) {
			this.game = game;
		}
		
		public function refresh():void {}

		public function pause():void {}

		public function play():void {}

		public function highscore():void {}

		public function enter():void {}

		public function leave():void {}

		public function changeState(state:Class):void {
			game.state.leave();
			game.state = new state(game);
			game.state.enter();
		}
	}
	
}
