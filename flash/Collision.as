package {
	
	public class Collision {

		public var a : Ball;
		public var b : Ball;
		public var diff : Vektor;
		public var overlap : Number;
		private const defaultFriction : Number = 0.1;
		public var friction : Number = defaultFriction;

		
		public function Collision(a : Ball, b : Ball, diff : Vektor, overlap : Number) {
			this.a = a;
			this.b = b;
			this.diff = diff;
			this.overlap = overlap;
		}

		/* Kollisions Test */
		public static function test(a : Ball, b : Ball) : Collision  {
			var diff : Vektor = b.position.sub(a.position);
			var overlap : Number = a.physicalRadius + b.physicalRadius - diff.length;
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
			var foo : Vektor  = (aforce.add(bforce)).mul(2).mul(1/(a.mass+b.mass));
			a.speed = foo.sub(a.speed);
			b.speed = foo.sub(b.speed);
		}
		
		private function applyFriction():void {
			a.speed = a.speed.mul(1-friction);
			b.speed = b.speed.mul(1-friction);
		}
		
		public function collide():void {
			positionBalls();
			momentumConservation();
			applyFriction();
		}
	}
}