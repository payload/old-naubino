public abstract class dragable {
	public Vektor position;
	public Vektor speed;
	public Vektor acceleration;
	public double mass;
	public double force;

	public abstract double getX();
	public abstract double getY();
	public abstract double getR();
	public abstract boolean isHit(Vektor c);
	public abstract boolean touches(dragable o);
	


	

	public abstract void move(Vektor v);
}
