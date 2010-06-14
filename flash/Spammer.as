package
{
	import flash.utils.Timer;

	public class Spammer
	{

		private var game:Game;
		public var difficulties : Array = [2500, 2000, 1700, 1300, 1000, 800];
		public var difficulty : int = 0;
		public var timer : Timer;

		public function Spammer(game:Game) {
			this.game = game;
			timer = utils.newTimer(difficulties[difficulty], randomPair);
			timer.start();
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

		public function spam():void {
			randomPair();
		}

		public function start():void {
			timer.start();
		}

		public function stop():void {
			timer.stop();
		}
	}
}
