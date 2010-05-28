package
{
	public class Spammer
	{

		private var game:Game;

		public function Spammer(game:Game) {
			this.game = game;
		}

		private function randomAngle():Number {
			return Math.random() * Math.PI * 2;
		}

		public function randomPair():void {
			// TODO create pair just outside of visible frame
			var field_size:Number = game.fieldSize;
			var v:Vektor = Vektor.polar(randomAngle(), (field_size));
			v = game.center.add(v);
			game.createPair(v);
		}
	}
}