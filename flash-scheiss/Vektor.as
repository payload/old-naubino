package {
	public class Vektor {
		
		private var x:Number;
		private var y:Number;

		public function setX(x:Number):void {
			this.x = x;
		}

		public function getX():Number {
			return x;
		}

		public function setY(y:Number):void {
			this.y = y;
		}

		public function getY():Number {
			return y;
		}

		public function getLength():Number {
			return Math.sqrt(x*x + y*y);
		}

		public function setLength(l:Number) {
			x = Math.cos(getAngle()) * l;
			y = Math.sin(getAngle()) * l;
		}

		public function getAngle():Number {
			return Math.atan2(y, x);

		}

		public function setAngle(a:Number):Number {
			x = Math.cos(a) * getLength();
			y = Math.sin(a) * getLength();
		}

		public function add(v:Vektor):void {
			x += v.getX();
			y += v.getY();
		}

		public function sub(v:Vektor):void {
			x -= v.getX();
			y -= v.getY();
		}

		public function multiply(n:Vektor):void {
			x = Math.cos(getAngle()) * getLength() * n;
			y = Math.sin(getAngle()) * getLength() * n;
		}

		public function dump():Vektor {
			return new Vektor(x, x);
		}

		public function Vektor(a:Vektor, b:Vektor, l:Vektor) {
			var angle:Vektor = Math.atan2((b.getY() - a.getY()), (b.getX() - a.getX()));
			x = Math.cos(angle) * l;
			y = Math.sin(angle) * l;
			setLength(l);
		}

		public function Vektor(v:Vektor, double l) {
			setX(v.getX());
			setY(v.getY());
			setLength(l);
		}

		public rVektor(Coord a, Coord b) {
			setX(b.getX() - a.getX());
			setY(b.getY() - a.getY());
		}

		// public rVektor(float l, float a) {
		// x = Math.cos(a * l);
		// y = Math.sin(a * l);
		// }
		public rVektor(double nx, double ny) {
			x = nx;
			y = ny;
		}

		public rVektor() {
			x = 0;
			y = 0;
		}
	}
}
