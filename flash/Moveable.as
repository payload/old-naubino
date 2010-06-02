package {
	public class Moveable {
		public var position : Vektor = new Vektor();
		public var speed : Vektor = new Vektor();
		public var acceleration : Vektor = new Vektor();;
		public var attracted:Boolean;
		public var attractedTo:Vektor;

		public function accelerate(v:Vektor):void {
			acceleration = acceleration.add(v);
		}

		public function get x():Number {
			return position.x;
		}

		public function set x(x:Number):void {
			position = new Vektor(x, position.y);
		}

		public function get y():Number {
			return position.y;
		}

		public function set y(y:Number):void {
			position = new Vektor(position.x, y);
		}
	}
}