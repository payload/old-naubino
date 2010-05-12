import java.util.ArrayList;
import java.util.List;

public class Ball extends dragable {
	public Coord position;
	public float radius;
	public Color color;

	private List<Joint> joints;

	public Ball(float x, float y, float size) {
		position = new Coord(x, y);
		speed = new rVektor();
		acceleration = new rVektor();
		radius = size;
		//mass = size;
		force = 1.5f;
		color = new Color(255, 0, 0);
		joints = new ArrayList<Joint>();
	}

//	private Game game = Game.instance();
	
	public void accelerate(rVektor v){
		acceleration.add(v);
	}

	public float getX() {
		return position.getX();
	}

	public float getY() {
		return position.getY();
	}

	public void setX(float x) {
		position.setX(x);
	}

	public void setY(float y) {
		position.setY(y);
	}

	public float getR() {
		return radius;
	}

	public boolean isHit(Coord c) {
		double distance = distanceTo(c).getLength();
		return (distance <= radius);
	}

	public boolean touches(dragable o) {
		double distance = distanceTo(o).getLength();
		return (distance <= (radius));
	}

	public rVektor distanceTo(Ball d) {
		return new rVektor(d.position, position);
	}

	public rVektor distanceTo(Coord o) {
		return new rVektor(o, position);
	}

	public void addJoint(Joint joint) {
		joints.add(joint);
	}

	public List<Joint> getJoints() {
		return joints;
	}

	public void resetJoints() {
		joints = new ArrayList<Joint>();
	}

	public void move(rVektor v){
		speed = v;
	}
	
	public void move(float x, float y) {
		speed = new rVektor(position, new Coord(x, y));
	}
}
