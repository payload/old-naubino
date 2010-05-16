
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
	
	/* Kollisions Test*/
	public static Collision test(Ball ball1, Ball ball2) {
		Vektor diff = ball1.position.sub(ball2.position);
		double overlap = ball1.radius + ball2.radius - diff.getLength();
		if (overlap > 0) 
			return new Collision(ball1, ball2, diff, overlap);
		else 
			return null;
	}
	
	public void positionBalls(Ball a, Ball b, double overlap){
		Vektor overlapV = diff.norm().mul(overlap * 0.5);
		a.position = a.position.add(overlapV.mul(-1));
		b.position = b.position.add(overlapV);
	}
	
	/* Kollisions behandlung */
	protected static void collide(Collision c) {
		Vektor a_collision;
		Vektor b_collision;
		a_collision = c.a.speed.mul(-1).add(calculateCollision(c));
		b_collision = c.b.speed.mul(-1).add(calculateCollision(c));
		c.positionBalls(c.a, c.b, c.overlap);
	}
	
	// calculate speed after a collision
	private static Vektor calculateCollision(Collision c){
		//physics are working here:
		/* b_collision is new vektor of b after collision with a (respectively a_collision for collision with b)
		 * b_collision = - b.speed + 2*((c.a.mass *a.speed) + (c.b.mass*b.speed))/(c.a.mass + c.b.mass)
		 * a_collision = - a.speed + 2*((c.a.mass *a.speed) + (c.b.mass*b.speed))/(c.a.mass + c.b.mass)
		 */
		Vektor minusSpeed = (c.a.speed.mul(c.a.mass).add(c.b.speed.mul(c.b.mass))).mul(2).mul(0.5);
		return minusSpeed;
	}
	
	/*@TODO: trying to keep joints from crossing*/
	
	protected static void crossedJoints(Ball a, Ball b, Joint j, Ball c, Ball d, Joint i){
		Vektor diff1 = a.position.sub(b.position);
		Vektor diff2 = c.position.sub(d.position);
		
	}
	
	
}
