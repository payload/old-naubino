package
{
	import flash.utils.Timer;

	public class Spammer
	{

		private var game:Game;
		public var difficulties : Array = [2500, 2000, 1700, 1300, 1000, 800];
		public var _difficulty : int = 0;
		public var difficultyStep : int = (60 * 6 * 1000) / difficulties.length;
		public var timer : Timer;
		public var nextDifficultyTimer : Timer;

		public function Spammer(game:Game) {
			this.game = game;
			timer = utils.newTimer(difficulties[difficulty], randomPair);
			nextDifficultyTimer = utils.newTimer(difficultyStep, nextDifficulty);
			//start();
		}

		private function randomAngle():Number {
			return Math.random() * Math.PI * 2;
		}

		public function randomPair():void {
			// TODO create pair just outside of visible frame
			var field_size:Number = game.fieldSize;
			var angle:Number = randomAngle();
			var v:Vektor = Vektor.polar(angle, 1);
			var margin:Number = 10;
			var corner0:Vektor = new Vektor(-margin, -margin);
			var corner1:Vektor = new Vektor(game.width + margin,game.height + margin);

			var hor0:Vektor = Vektor.interception(corner0, new Vektor(1,0), game.center, v);
			var ver0:Vektor = Vektor.interception(corner0, new Vektor(0,1), game.center, v);
			var hor1:Vektor = Vektor.interception(corner1, new Vektor(1,0), game.center, v);
			var ver1:Vektor = Vektor.interception(corner1, new Vektor(0,1), game.center, v);
			
			if(hor0 === null)
					  hor0 = hor1;
			if(ver0 === null)
					  ver0 = ver1;

			if(hor0.sub(game.center).length < ver0.sub(game.center).length){
				game.createPair(hor0);
			}
			else{
				game.createPair(ver0);
			}
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
