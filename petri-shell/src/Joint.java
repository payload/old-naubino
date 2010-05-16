public class Joint{
	
	public Ball a;
	public Ball b;
	
	private double length;
	private double strength;

	public Joint(Ball b1, Ball b2, double length, double strength) {
		a = b1;
		b = b2;
		this.length = length;
		this.setStrength(strength);
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
