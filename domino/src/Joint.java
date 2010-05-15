public class Joint{
	
	public Ball a;
	public Ball b;
	
	private double length;
	private double strength;
	private double lowerLimit;
	private double upperLimit;
	
	public static final double defaultLength = 40;
	public static final double defaultStrength = 1;
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
		this.strength = strength;
		this.lowerLimit = lowerLimit;
		this.upperLimit = upperLimit;
	}
	
	private void hardRestrict(Vektor diff, double limit) {
		// TODO
	}
	
	/* Federkraefte zwischen gejointen Baellen */
	public void swingBalls() {
		/*
		 *  es gibt eine maximale Kompression(lowerLimit) und
		 *  Ausdehnung(upperLimit). Die maximale Rückstoßkraft(strength) wird
		 *  nur an den Limits erreicht. Die Rückstoßkraft steigt exponentiell.
		 */
		Vektor real_diff   = b.position.sub(a.position);
		double real_length = real_diff.getLength();
		double real_angle  = real_diff.getAngle();
		if (real_length < lowerLimit) {
			real_length = lowerLimit;
			hardRestrict(real_diff, lowerLimit);
		} else
		if (real_length > upperLimit) {
			real_length = upperLimit;
			hardRestrict(real_diff, upperLimit);
		}
		
		double force;
		if (real_length < length) {
			force = -Math.pow(strength, real_length / lowerLimit);
		} else {
			force = Math.pow(strength, real_length / upperLimit);
		}
		Vektor force_vektor = Vektor.polar(real_angle, force);
		a.accelerate(force_vektor);
		b.accelerate(force_vektor.mul(-1));
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
