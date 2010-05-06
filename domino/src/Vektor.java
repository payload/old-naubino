import java.lang.Math.*;

public class vektor {
	coor a;
	coor b = new coor();
	float angle;
	float length;

	vektor(coor a, float angle, float length) {
		this.a = a;
		this.angle = angle;
		this.length = length;

		this.b.x = (float) (this.a.x + Math.cos(this.angle) * this.length);
		this.b.y = (float) (this.a.y + Math.sin(this.angle) * this.length);
	}

	public vektor(coor na, coor nb) {
		this.a = na;
		this.b = nb;
		this.length = (float) Math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y)
				* (a.y - b.y));

		this.angle = (float) Math.atan2((nb.y - na.y), (nb.x - na.x));
	}

	public vektor dump() {
		return new vektor(this.a.dump(), angle, length);
	}

	public vektor scoot(float len) {
		coor sa = new coor();
		sa.x = (float) (this.a.x + Math.cos(this.angle) * len);
		sa.y = (float) (this.a.y + Math.sin(this.angle) * len);

		return new vektor(sa, this.angle, this.length);

	}
	
	public void rotate(float ang) {
		this.angle += ang;
	}
	
	public vektor add(vektor other) {
		return new vektor(this.a,other.b);
	}
	
	public vektor add(coor other) {
		return new vektor(this.a, other);
	}
	
	public vektor append(vektor other) {
		return new vektor(this.b,other.angle,other.length);
	}
	
	public vektor append() {
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

	vektor cut(float len) {
		vektor cv = new vektor(this.a, this.angle, this.length * len);
		return cv;
	}

	/*void draw() {
		line(a.x, a.y, b.x, b.y);
	}*/

}
