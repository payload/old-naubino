
public class Collision {

	public Ball a;
	public Ball b;
	public Vektor diff;
	public double overlap;
	private double friction = 0.1;

	
	public Collision(Ball a, Ball b, Vektor diff, double overlap) {
		this.a = a;
		this.b = b;
		this.diff = diff;
		this.overlap = overlap;
	}

	/* Kollisions Test */
	public static Collision test(Ball ball1, Ball ball2) {
		Vektor diff = ball2.position.sub(ball1.position);
		double overlap = ball1.radius + ball2.radius - diff.getLength();
		if (overlap > 0)
			return new Collision(ball1, ball2, diff, overlap);
		else
			return null;
	}
	
	private void positionBalls() {
		Vektor overlapV = diff.norm().mul(overlap * 0.5);
		a.position = a.position.add(overlapV.mul(-1));
		b.position = b.position.add(overlapV);
	}
	
	private void momentumConservation() {
		Vektor aforce = a.speed.mul(a.mass);
		Vektor bforce = b.speed.mul(b.mass);
		Vektor foo = (aforce.add(bforce)).mul(2).mul(1/(a.mass+b.mass));
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
