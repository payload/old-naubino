public class Joint {
	
	public Ball a;
	public Ball b;
	
	private double length;
	private double strength;
	private double lowerLimit;
	private double upperLimit;
	
	public Joint(Ball a, Ball b) {
		this(a, b, 40, 0.1, 5, 80);
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
}
