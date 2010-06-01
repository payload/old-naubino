package{
	public class Joint{
		
		public var a:Naub;
		public var b:Naub;
		
		private var _length:Number;
		private var _strength:Number;
		public var friction:Number;
		
		public static const defaultLength:Number = 40;
		public static const defaultStrength:Number = .3;
		
		public function Joint(a:Naub, b:Naub) {
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
				force = force.add(springVector.norm.mul(-(r-defaultLength)*defaultStrength));
			
			force = force.add(a.speed.sub(b.speed).mul(-friction));
			a.accelerate(force);
			b.accelerate(force.mul(-1));
		}
		
		public function opposite(b:Naub):Naub {
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