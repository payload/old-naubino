package {
	public class Vektor {
		
		private var _x:Number;
		private var _y:Number;

		public function get x():Number {
			return _x;
		}

		public function get y():Number {
			return _y;
		}

		public function get length():Number {
			return Math.sqrt(x*x + y*y);
		}

		public static function polar(a:Number, l:Number) : Vektor {
			var x:Number = Math.cos(a) * l;
			var y:Number = Math.sin(a) * l;
			return new Vektor(x, y);
		}
		
		public function Vektor(x:Number = 0, y:Number = 0) {
			_x = x;
			_y = y;
		}

		public function get angle():Number {
			return Math.atan2(y, x);
		}

		public function add(v:Vektor):Vektor {
			return new Vektor(x + v.x, y + v.y);
		}

		public function sub(v:Vektor):Vektor {
			return new Vektor(x - v.x, y - v.y);
		}

		public function mul(n:Number):Vektor {
			var x:Number = this.x * n;
			var y:Number = this.y * n;
			return new Vektor(x, y);
		}
		
		public function get norm() : Vektor {
			return Vektor.polar(angle, 1);
		}
		
		public function toString():String {
			return "[" + x +", " + y +"]";
		}
	}
}
