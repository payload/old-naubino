package{
	public class Joint{
		
		public var a:Moveable;
		public var b:Moveable;
		
		private var _length:Number;
		private var _strength:Number;
		public var friction:Number;
		
		public static const defaultLength:Number = 40;
		public static const defaultStrength:Number = .3;
		
		public function Joint(a:Moveable, b:Moveable) {
			this.a = a;
			this.b = b;
			length = defaultLength;
			strength = defaultStrength;
			friction = 0.1;
		}

		public function spring():void {
			var springVector:Vektor = a.position.sub(b.position);
			var force:Vektor = new Vektor();
			var r:Number = springVector.length;
			
			if(r != 0)
				force = force.add(springVector.norm.mul(-(r-length)*strength));
			
			force = force.add(a.speed.sub(b.speed).mul(-friction));
			a.accelerate(force);
			b.accelerate(force.mul(-1));
		}
		
		public function opposite(b:Moveable):Moveable {
			if (a == b)
				return this.b;
			else
				return a;
		}

		public function set length(l:Number):void {
			_length = l;
		}

		public function get length():Number {
			return _length;
		}

		public function set strength(s:Number):void {
			_strength = s;
		}

		public function get strength():Number {
			return _strength;
		}

		public function equals(o:Joint):Boolean {
			if(this.a == o.a && this.b == o.b) return true;
			if(this.a == o.b && this.b == o.a) return true;
			return false;
		}

		
	}
}