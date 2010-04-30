public class Joint {
	public Ball a;
	public Ball b;
	public Ball taily;

	private float length;

	public Joint(Ball b1, Ball b2) {
		a = b1;
		b = b2;
		length = 50;
	}

	public float getLength() {
		float length = (float) Math.sqrt((a.getX() - b.getX()) * (a.getX() - b.getX())
				+ Math.pow(a.getY() - b.getY(), 2));
		return length;
	}

	public void setTaily() {
		if (a.isActive)
			taily = b;
		else
			taily = a;
	}

	public Ball opp(Ball b2) {
		if (a == b2)
			return b;
		else
			return a;
	}
}
