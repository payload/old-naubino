import java.lang.Math.*;

public class Vektor {
	Coord a;
	Coord b = new Coord();
	float angle;
	float length;

	Vektor(Coord a, float angle, float length) {
		this.a = a;
		this.angle = angle;
		this.length = length;

		this.b.x = (float) (this.a.x + Math.cos(this.angle) * this.length);
		this.b.y = (float) (this.a.y + Math.sin(this.angle) * this.length);
	}

	public Vektor(Coord na, Coord nb) {
		this.a = na;
		this.b = nb;
		this.length = (float) Math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y)
				* (a.y - b.y));

		this.angle = (float) Math.atan2((nb.y - na.y), (nb.x - na.x));
	}

	public Vektor dump() {
		return new Vektor(this.a.dump(), angle, length);
	}

	public Vektor scoot(float len) {
		Coord sa = new Coord();
		sa.x = (float) (this.a.x + Math.cos(this.angle) * len);
		sa.y = (float) (this.a.y + Math.sin(this.angle) * len);

		return new Vektor(sa, this.angle, this.length);

	}
	
	public void rotate(float ang) {
		this.angle += ang;
	}
	
	public Vektor add(Vektor other) {
		return new Vektor(this.a,other.b);
	}
	
	public Vektor add(Coord other) {
		return new Vektor(this.a, other);
	}
	
	public Vektor append(Vektor other) {
		return new Vektor(this.b,other.angle,other.length);
	}
	
	public Vektor append() {
		return append(this);
	}

	public float getX() {
		return (float)this.a.x;		
	}
	
	public float getY() {
		return (float)this.a.y;		
	}
	
	public String toString() {		
		return "[" 
		+ this.a.x	 +","
		+ this.a.y   + "] : "
		+ this.angle + "->" 
		+ this.length;
	}

	Vektor cut(float len) {
		Vektor cv = new Vektor(this.a, this.angle, this.length * len);
		return cv;
	}

	/*void draw() {
		line(a.x, a.y, b.x, b.y);
	}*/

}
