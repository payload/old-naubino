import java.util.ArrayList;
import java.util.List;

public class Ball extends dragable {
	private Coord position;
	public float radius;
	public Color color;

	private List<Joint> joints;

	public Ball(float x, float y, float size) {
		position = new Coord(x, y);
		radius = size;
		color = new Color(255, 0, 0);
		joints = new ArrayList<Joint>();
	}

	public float getX() {
		return position.x;
	}

	public float getY() {
		return position.y;
	}

	public void setX(float x) {
		position.x = x;
	}

	public void setY(float y) {
		position.y = y;
	}

	public float getR() {
		return radius;
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

	public boolean isHit(Coord c) {
		float distance = (float) Math.sqrt(Math.pow((c.x - position.x), 2)
				+ Math.pow((c.y - position.y), 2));
		return (distance <= radius / 2);
	}

	public void move(float x, float y) {

		setX(x);
		setY(y);

		float tailyX;
		float tailyY;
		float dx;
		float dy;
		Ball taily;

	}
}
