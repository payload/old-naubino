import java.util.ArrayList;
import java.util.List;

public class Ball extends dragable {
	public Vektor position;
	public double radius;
	public Color color;

	private List<Joint> joints;

	public Ball(double x, double y, double size) {
		position = new Vektor(x, y);
		speed = new Vektor();
		acceleration = new Vektor();
		radius = size;
		//mass = size;
		force = 1.5f;
		color = new Color(255, 0, 0);
		joints = new ArrayList<Joint>();
	}

//	private Game game = Game.instance();
	
	public void accelerate(Vektor v){
		acceleration.add(v);
	}

	public double getX() {
		return position.getX();
	}

	public double getY() {
		return position.getY();
	}

	public void setX(double x) {
		position.setX(x);
	}

	public void setY(double y) {
		position.setY(y);
	}

	public double getR() {
		return radius;
	}

	public boolean isHit(Vektor c) {
		double distance = distanceTo(c).getLength();
		return (distance <= radius);
	}

	public boolean touches(dragable o) {
		double distance = distanceTo(o).getLength();
		return (distance <= (radius));
	}

	public Vektor distanceTo(dragable d){
		return position.sub(d.position);
	}
	
	public Vektor distanceTo(Vektor o){
		return position.sub(o);
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

	public void move(Vektor v){
		speed = v;
	}

}
