import java.util.ArrayList;
import java.util.List;

public class Ball extends dragable {
	private Coord position;
	public float radius;
	public Color color;
	public zyklusfarbe besuch = zyklusfarbe.blue;
	public boolean unMoved;

	private List<Joint> joints;

	public Ball(float x, float y, float size) {
		position = new Coord(x, y);
		radius = size;
		color = new Color(255, 0, 0);
		joints = new ArrayList<Joint>();
		unMoved = true;
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
		unMoved = false;

		setX(x);
		setY(y);

		float tailyX;
		float tailyY;
		float dx;
		float dy;
		Ball taily;

		for (Joint j : joints) {
			taily = j.opp(this);	
//			System.out.println(taily.color.name);
			if (taily.unMoved) {
				taily.unMoved = false;
//				if (color.name.compareTo("purple") == 0)
//					System.out.println(color.name + "\t" + getX() + "-"
//							+ getY() + " moving");

				dx = x - taily.getX();
				dy = y - taily.getY();
				float angle = (float) Math.atan2(dy, dx);
				float length = j.getLength();

				tailyX = x - ((float) Math.cos(angle) * length);
				tailyY = y - ((float) Math.sin(angle) * length);

				taily.move(tailyX, tailyY);
				// taily.unMoved = true;
			}
			unMoved = true;
		}
	}
}
