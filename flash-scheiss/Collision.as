
public class Collision {

	var a : Ball;
	var b : Ball;
	var diff : Vektor;
	var overlap : Number;
	const colfriction : Number = 0.1;

	
	function (a : Ball, b : Ball, diff : Vektor, overlap : Number) : Collision {
		this.a = a;
		this.b = b;
		this.diff = diff;
		this.overlap = overlap;
	}

	/* Kollisions Test */
	static function test(a : Ball, b : Ball) : Collision  {
		Vektor diff = b.position.sub(a.position);
		double overlap = a.physicalRadius + b.physicalRadius - diff.getLength();
		if (overlap > 0)
			return new Collision(a, b, diff, overlap);
		else
			return null;
	}
	
	function positionBalls() {
		overlapV : Vektor = diff.norm().mul(overlap * 0.5);
		a.position = a.position.add(overlapV.mul(-1));
		b.position = b.position.add(overlapV);
	}
	
	function momentumConservation() {
		aforce : Vektor = a.speed.mul(a.mass);
		bforce : Vektor = b.speed.mul(b.mass);
		foo : Vektor  = (aforce.add(bforce)).mul(2).mul(1/(a.mass+b.mass));
		a.speed = foo.sub(a.speed);
		b.speed = foo.sub(b.speed);
	}
	
	private void applyFriction() {
		a.speed = a.speed.mul(1-friction);
		b.speed = b.speed.mul(1-friction);
	}
	
	public void collide() {
		positionBalls();
		momentumConservation();
		applyFriction();
	}

}
