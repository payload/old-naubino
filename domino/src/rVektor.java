/* relativer Vektor
 * ja ich habe es eingesehen
 * schön Simple ist er*/
// TODO casting entfernen
public class rVektor {
	private double x;
	private double y;
	
	/*only for caching*/
	private double length;
	private double angle;

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
		length = Math.sqrt(Math.pow(x,2) + Math.pow(y,2));
		return length;
	}

	public void setLength(double l) {
		length = l;
		x = Math.cos(this.getAngle()) * l;
		y = Math.sin(this.getAngle()) * l;
	}

	public double getAngle() {
		angle = Math.atan2(y, x);
		return angle;
		
	}

	public void setAngle(double a) {
		x = Math.cos(a) * this.getLength();
		y = Math.sin(a) * this.getLength();
	}

	public void add(rVektor v) {
		this.x = this.x + v.getX();
		this.y = this.y + v.getY();
	}

	public void sub(rVektor v) {
		this.x = this.x - v.getX();
		this.y = this.y - v.getY();
	}

	public void multiply(double n){
		x = Math.cos(this.getAngle()) * getLength() * n;
		y = Math.sin(this.getAngle()) * getLength() * n;
	}
	
	public rVektor dump(){
		return new rVektor(this.x, this.x);
	}

	public rVektor(Coord a, Coord b, double l) {
		double angle = Math.atan2((b.getY()-a.getY()),(b.getX()-a.getX()));
		x = Math.cos(angle) * l;
		y = Math.sin(angle) * l;
		setLength(l);
	}

	public rVektor(Coord a, Coord b) {
		setX(b.getX() - a.getX());
		setY(b.getY() - a.getY());
	}

	public rVektor(float l, float a) {
		x = Math.cos(a * l);
		y = Math.sin(a * l);
	}
	public rVektor(double nx, double ny){
		x = nx;
		y = ny;
	}
	public rVektor(){
		x = 0;
		y = 0;
	}
}
