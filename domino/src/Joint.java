public class Joint {
	public Ball a;
	public Ball b;
//	public Ball taily;

	private float length;

	public Joint(Ball b1, Ball b2) {
		a = b1;
		b = b2;
		length = 50;
	}
	
	public double getStretch() {
		return a.distanceTo(b).getLength();
	}

	public float getLength() {
		float length = (float) Math.sqrt((a.getX() - b.getX()) * (a.getX() - b.getX())
				+ Math.pow(a.getY() - b.getY(), 2));
		return length;
	}

	public Ball opp(Ball b2) {
		if (a == b2)
			return b;
		else
			return a;
	}
}
