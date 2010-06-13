public class Joint{
	
	public Ball a;
	public Ball b;
	
	private double length;
	private double strength;
	private double friction;
	
	public static final double defaultLength = 40;
	public static final double defaultStrength = .3;
	
	public Joint(Ball a, Ball b) {
		this(a, b, defaultLength, defaultStrength);
	}

	public Joint(Ball b1, Ball b2, double length, double strength) {
		a = b1;
		b = b2;
		this.length = length;
		this.strength = strength;
		this.friction = 0.1;
	}

	public void spring() {
		Vektor springVector = a.position.sub(b.position);
		Vektor force = new Vektor();
		
		double r = springVector.getLength();
		if(r != 0)
			force = force.add(springVector.norm().mul(-(r-defaultLength)*defaultStrength));
		
		force = force.add(a.speed.sub(b.speed).mul(-friction));
		a.accelerate(force);
		b.accelerate(force.mul(-1));
	}
	
	public Ball opposite(Ball b) {
		if (a == b)
			return this.b;
		else
			return a;
	}

	public void setLength(double length) {
		this.length = length;
	}

	public double getLength() {
		return length;
	}

	public void setStrength(double strength) {
		this.strength = strength;
	}

	public double getStrength() {
		return strength;
	}

	public boolean equals(Joint o) {
		if(this.a == o.a && this.b == o.b) return true;
		if(this.a == o.b && this.b == o.a) return true;
		return false;
	}

	
}
