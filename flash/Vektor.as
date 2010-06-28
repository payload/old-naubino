package {
	public class Vektor {
		
		private var _x:Number;
		private var _y:Number;

		public static const O : Vektor = new Vektor(0, 0);

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

		public static  function interception(p1:Vektor,v1:Vektor,p2:Vektor,v2:Vektor):Vektor{
			var n2:Number = (p1.y-p2.y)*v1.x + (p2.x-p1.x)*v1.y;
			n2 = n2/(v2.y*v1.x-v2.x*v1.y);
			
			if(n2 < 0) return null;

			var ipoint:Vektor = p2.add(v2.mul(n2));
			return ipoint;
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
