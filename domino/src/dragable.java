public abstract class dragable {
	public Coord position;
	public rVektor speed;
	public rVektor acceleration;
	public float mass;
	public float force;

	public abstract float getX();
	public abstract float getY();
	public abstract float getR();
	public abstract boolean isHit(Coord c);
	public abstract boolean touches(dragable o);
	

	public rVektor distanceTo(dragable d){
		return new rVektor(d.position, position);
	}
	
	public rVektor distanceTo(Coord o){
		return new rVektor(o,position);
	}
	
	
	public abstract void move(float x, float y);
}
