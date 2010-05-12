
public class Vektor {
	public Coord a;
	public Coord b = new Coord();
	private float angle;
	private float length;

	public void setAngle(float angle) {
		this.angle = angle;
	}

	public float getAngle() {
		return angle;
	}

	public void setLength(float length) {
		this.length = length;
	}

	public float getLength() {
		return length;
	}

	Vektor(Coord a, float angle, float length) {
		this.a = a;
		this.setAngle(angle);
		this.setLength(length);

		this.b.setX((float) (this.a.getX() + Math.cos(this.getAngle()) * this.getLength()));
		this.b.setY((float) (this.a.getY() + Math.sin(this.getAngle()) * this.getLength()));
	}

	public Vektor(Coord na, Coord nb) {
		this.a = na;
		this.b = nb;
		this.setLength((float) Math.sqrt((a.getX() - b.getX()) * (a.getX() - b.getX()) + (a.getY() - b.getY())
				* (a.getY() - b.getY())));

		this.setAngle((float) Math.atan2((nb.getY() - na.getY()), (nb.getX() - na.getX())));
	}

	public Vektor(Coord na, Coord nb, float l) {
		this.a = na;
		this.setLength(l);
		this.setAngle((float) Math.atan2((nb.getY() - na.getY()), (nb.getX() - na.getX())));
		this.b.setX((float) (this.a.getX() + Math.cos(this.getAngle()) * this.getLength()));
		this.b.setY((float) (this.a.getY() + Math.sin(this.getAngle()) * this.getLength()));
	}

	public Vektor dump() {
		return new Vektor(this.a.dump(), getAngle(), getLength());
	}

	public Vektor scoot(float len) {
		Coord sa = new Coord();
		sa.setX((float) (this.a.getX() + Math.cos(this.getAngle()) * len));
		sa.setY((float) (this.a.getY() + Math.sin(this.getAngle()) * len));

		return new Vektor(sa, this.getAngle(), this.getLength());

	}
	
	public void rotate(float ang) {
		this.setAngle(this.getAngle() + ang);
	}
	
	public Vektor add(Vektor other) {
		Vektor link = new Vektor(this.b,other.getAngle(),other.length);
		return new Vektor(this.a,link.b);
	}
		
	public Vektor append(Vektor other) {
		return new Vektor(this.b,other.getAngle(),other.getLength());
	}
	
	public Vektor append() {
		return append(this);
	}

	public float getX() {
		return (float)this.a.getX();		
	}
	
	public float getY() {
		return (float)this.a.getY() ;		
	}
	
	public String toString() {		
		return "[" 
		+ this.a.getX()	 +","
		+ this.a.getY()   + "] : "
		+ this.getAngle() + "->" 
		+ this.getLength();
	}

	Vektor cut(float len) {
		Vektor cv = new Vektor(this.a, this.getAngle(), this.getLength() * len);
		return cv;
	}

	/*void draw() {
		line(a.x, a.y, b.x, b.y);
	}*/

}
