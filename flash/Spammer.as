package
{
	import flash.utils.Timer;

	public class Spammer
	{

		private var game:Game;
		public var difficulties : Array = [2500, 2000, 1700, 1300, 1000, 800];
		public var _difficulty : int = 0;
		public var difficultyStep : int = (60 * 4 * 1000) / difficulties.length;
		public var timer : Timer;
		public var nextDifficultyTimer : Timer;

		public function Spammer(game:Game) {
			this.game = game;
			timer = utils.newTimer(difficulties[difficulty], randomPair);
			nextDifficultyTimer = utils.newTimer(difficultyStep, nextDifficulty);
			start();
		}

		private function randomAngle():Number {
			return Math.random() * Math.PI * 2;
		}

		public function randomPair():void {
			// TODO create pair just outside of visible frame
			var field_size:Number = game.fieldSize;
			var v:Vektor = Vektor.polar(randomAngle(), (field_size*1.6));
			v = game.center.add(v);
			game.createPair(v);
		}

		public function get difficulty():int {
			return _difficulty;
		}

		public function set difficulty(x:int):void {
			if (_difficulty != x) {
				_difficulty = x;
				timer.delay = difficulties[difficulty];
			}
		}

		public function nextDifficulty():void {
			difficulty = Math.min(difficulty + 1, difficulties.length - 1);
		}

		public function spam():void {
			randomPair();
		}

		public function start():void {
			timer.start();
			nextDifficultyTimer.start();
		}

		public function stop():void {
			timer.stop();
			nextDifficultyTimer.stop();
		}

		public function reset():void {
			timer.reset();
			nextDifficultyTimer.reset();
			difficulty = 0;
		}
	}
}
