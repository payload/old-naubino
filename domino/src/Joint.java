public class Joint{
	
	public Ball a;
	public Ball b;
	
	private double length;
	private double strength;
	private double lowerLimit;
	private double upperLimit;
	
	public static final double defaultLength = 40;
	public static final double defaultStrength = 0.1;
	public static final double defaultLowerLimit = 5;
	public static final double defaultUpperLimit = 80;
	
	public Joint(Ball a, Ball b) {
		this(a, b, defaultLength, defaultStrength, 
			defaultLowerLimit, defaultUpperLimit);
	}

	public Joint(Ball b1, Ball b2, double length, double strength, double lowerLimit, double upperLimit) {
		a = b1;
		b = b2;
		this.length = length;
		this.setStrength(strength);
		this.lowerLimit = lowerLimit;
		this.upperLimit = upperLimit;
	}
	
	/* Federkraefte zwischen gejointen Baellen */
	public void swingBalls() {
		Vektor real_diff   = b.position.sub(a.position);
		double real_diff_length = real_diff.getLength();
		double wish_length = getLength(); 
		Vektor wish_diff   = Vektor.polar(real_diff.getAngle(), wish_length);
		Vektor force       = wish_diff.sub(real_diff);
		force = force.mul((real_diff_length / wish_length) * getStrength());
		a.accelerate(force.mul(-1));
		b.accelerate(force);
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
