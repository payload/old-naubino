public class Ball extends dragable {
	private Coordinate position;
	public float radius;
	public Color color;
	public boolean isActive = false;
	public zyklusfarbe besuch = zyklusfarbe.blue;

	private Joint joint;

	public void addJoint(Joint joint) {
		this.joint = joint;
	}

	public Joint getJoint() {
		return joint;
	}

	public void resetJoint() {
		if (isActive) {
			joint.taily = null;
		}
		isActive = false;
	}

	public boolean isHit(Coordinate c) {
		float distance = (float) Math.sqrt(Math.pow((c.x - position.x), 2) + Math.pow((c.y - position.y), 2));
		return (distance <= radius / 2);
	}

	public Ball(float x, float y, float size) {
		position = new Coordinate(x, y);
		radius = size;
		color = new Color(255, 0, 0);
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

}
