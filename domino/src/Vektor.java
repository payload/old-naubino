/* relativer Vektor
 * ja ich habe es eingesehen
 * schön Simple ist er*/
// TODO casting entfernen
public class Vektor {
	private double x;
	private double y;

	/* this used to be simple - now it just has tones of constructors */

	public void setX(double x) {
		this.x = x;
	}

	public double getX() {
		return x;
	}

	public void setY(double y) {
		this.y = y;
	}

	public double getY() {
		return y;
	}

	public double getLength() {
		return Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2));
	}

	public void setLength(double l) {
		x = Math.cos(this.getAngle()) * l;
		y = Math.sin(this.getAngle()) * l;
	}

	public double getAngle() {
		return Math.atan2(y, x);

	}

	public void setAngle(double a) {
		x = Math.cos(a) * this.getLength();
		y = Math.sin(a) * this.getLength();
	}

	public Vektor add(Vektor v) {
		return new Vektor(x + v.getX(), y + v.getY());
	}

	public Vektor sub(Vektor v) {
		return new Vektor(this.x - v.getX(), this.y - v.getY());
	}

//	public void multiply(double n) {
//		x = Math.cos(this.getAngle()) * getLength() * n;
//		y = Math.sin(this.getAngle()) * getLength() * n;
//	}

	public Vektor dump() {
		return new Vektor(this.x, this.x);
	}

	public Vektor(Vektor a, Vektor b, double l) {
		double angle = Math.atan2((b.getY() - a.getY()), (b.getX() - a.getX()));
		x = Math.cos(angle) * l;
		y = Math.sin(angle) * l;
		setLength(l);
	}

	public Vektor(Vektor v, double l) {
		setX(v.getX());
		setY(v.getY());
		setLength(l);
	}


	public Vektor(double nx, double ny) {
		x = nx;
		y = ny;
	}

	public Vektor() {
		x = 0;
		y = 0;
	}
}
