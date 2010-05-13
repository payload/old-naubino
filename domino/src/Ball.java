import java.util.ArrayList;
import java.util.List;

public class Ball {
	public Vektor position;
	public Vektor speed;
	public Vektor acceleration;
	public double radius;
	public Color color;

	private List<Joint> joints;

	public Ball(Vektor position, double radius) {
		this.position = position;
		this.radius = radius;
		speed = new Vektor();
		acceleration = new Vektor();
		color = new Color(255, 0, 0);
		joints = new ArrayList<Joint>();
	}

	public void accelerate(Vektor v){
		acceleration = acceleration.add(v);
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

	public boolean touches(Ball o) {
		double distance = distanceTo(o).getLength();
		return (distance <= (radius));
	}

	public Vektor distanceTo(Ball d){
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

}
