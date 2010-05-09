import java.util.ArrayList;
import java.util.List;

public class Ball extends dragable {
	public Coord position;
	public float radius;
	public Color color;
		

	private List<Joint> joints;

	public Ball(float x, float y, float size) {
		position = new Coord(x, y);
		speed = new rVektor(0,1);
		acceleration = new rVektor();///**/new rVektor(position, new Coord(300, 200), 1.5);
		radius = size;
		mass = 30;
		force = 1.5f; 
		color = new Color(255, 0, 0);
		joints = new ArrayList<Joint>();
	}

	private Game game = Game.instance();

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
	
	public boolean touches(dragable o){
		double distance = distanceTo(o).getLength();
		return (distance <= (radius + 10));
	}
	
	public rVektor distanceTo(dragable d){
		return new rVektor(d.position, position);
	}
	
	public rVektor distanceTo(Coord o){
		return new rVektor(o,position);
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

	public void move(float x, float y) {
		setX(x);
		setY(y);
		// Coord pointer = new Coord(x,y);
		// direction = new rVektor(x-position.getX(), y-position.getY());

	}
}
