package {
	
	public class Collision {

		public var a : Physical;
		public var b : Physical;
		public var diff : Vektor;
		public var overlap : Number;
		private const defaultFriction : Number = 0.7;
		public var friction : Number = defaultFriction;

		public function Collision(a : Physical, b : Physical, diff : Vektor, overlap : Number) {
			this.a = a;
			this.b = b;
			this.diff = diff;
			this.overlap = overlap;
		}

		/* Kollisions Test */
		public static function test(a : Physical, b : Physical) : Collision  {
			var diff : Vektor = b.position.sub(a.position);
			var overlap : Number = a.radius + b.radius - diff.length;
			if (overlap > 0)
				return new Collision(a, b, diff, overlap);
			else
				return null;
		}
		
		private function positionBalls():void {
			var overlapV : Vektor = diff.norm.mul(overlap * 0.5);
				a.position = a.position.add(overlapV.mul( -1));
				b.position = b.position.add(overlapV);
		}
		
		private function momentumConservation():void {
			var aforce : Vektor = a.speed.mul(a.mass);
			var bforce : Vektor = b.speed.mul(b.mass);
			//var foo : Vektor  = (aforce.add(bforce)).mul(2).mul(1/(a.mass+b.mass));
			var foo : Vektor = (aforce.add(bforce));
			foo = foo.mul(0.5);	
			a.speed = foo.sub(a.speed);
			b.speed = foo.sub(b.speed);

			//a.speed = (aforce.add(bforce)).sub((a.speed.sub(b.speed)).mul(0.85));
			//b.speed = (aforce.add(bforce)).sub((b.speed.sub(a.speed)).mul(0.85));
		}
		
		private function applyFriction():void {
			a.speed = a.speed.add(a.speed.mul(friction-1));
			b.speed = b.speed.add(b.speed.mul(friction-1));
		}
		
		public function collide():void {
			positionBalls();
			//momentumConservation();
			applyFriction();
		}
	}
}
