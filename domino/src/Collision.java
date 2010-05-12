
public class Collision {

	public Ball a;
	public Ball b;
	public Vektor diff;
	public double overlap;
	
	public Collision(Ball a, Ball b, Vektor diff, double overlap) {
		this.a = a;
		this.b = b;
		this.diff = diff;
		this.overlap = overlap;
	}
	
	public static Collision test(Ball ball1, Ball ball2) {
		Vektor diff = ball1.position.sub(ball2.position);
		double overlap = ball1.radius + ball2.radius - diff.getLength();
		if (overlap > 0) 
			return new Collision(ball1, ball2, diff, overlap);
		else 
			return null;
	}
}
