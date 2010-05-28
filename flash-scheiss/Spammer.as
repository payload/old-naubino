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

		public function randomPair() {
			// TODO create pair just outside of visible frame
			field_size:Number = game.getFieldSize();
			v:Vektor = Vektor.polar(randomAngle(), (field_size));
			v = game.getCenter().add(v);
			game.createPair(v);
		}
	}
}