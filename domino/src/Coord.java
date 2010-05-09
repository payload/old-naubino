
public class Coord {
	private float x;
	private float y;

	public void setX(float x) {
		this.x = x;
	}

	public void setY(float y) {
		this.y = y;
	}

	public float getY() {
		return y;
	}

	public float getX() {
		return x;
	}

	Coord(float x, float y) {
		this.setX(x);
		this.setY(y);
	}

	Coord() {
	}

	public void left(float diff) {
		this.setX(this.getX() - diff);
	}

	public void right(float diff) {
		this.setX(this.getX() + diff);
	}

	public void up(float diff) {
		this.setY(this.getY() - diff);
	}

	public Coord add(Vektor v) {
		Vektor link = new Vektor(this, v.getAngle(), v.getLength());
		return link.b;
	}

	public Coord add(rVektor v) {
		return new Coord(this.getX() + (float) v.getX(), this.getY() + (float) v.getY());
	}

	public void down(float diff) {
		this.setY(this.getY() + diff);
	}

	Coord dump() {
		return new Coord(getX(), getY());
	}
}