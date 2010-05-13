import java.util.*;
import java.util.concurrent.*;

public class Game {

	private static final Game instance = new Game();
	protected List<Ball> balls;
	protected List<Joint> joints;
	private double fieldSize;
	private double jointLength = 40;
	private double jointStrength = 0.1;
	private Vektor pointer;
	private Physics physics;

	public Ball active;
	public int width = 600;
	public int height = 400;

	private float ballsize = 15;
	private int refreshInterval = 50;

	public Vektor getCenter() {
		return new Vektor(width / 2, height / 2);
	}

	public void setPointer(Vektor pointer) {
		this.pointer = pointer;
	}

	public int getNumberOfJoints() {
		return joints.size();
	}

	private Timer timer;
	private TimerTask task = new TimerTask() {
		public void run() {
			refresh();
		}
	};

	private Game() {
		balls = new CopyOnWriteArrayList<Ball>();
		joints = new CopyOnWriteArrayList<Joint>();
		setFieldSize(320);
		pointer = getCenter();
		physics = new Physics(this);

		timer = new Timer();
		timer.schedule(task, 0, refreshInterval);
	}

	public static Game instance() {
		return instance;
	}

	public void refresh() {
		physics.physik();
	}

	private Ball createBall(Vektor v) {
		Ball ball = new Ball(v, ballsize);
		ball.color = Color.random();
		balls.add(ball);
		return ball;
	}

	private void createPair(Vektor v) {
		Vektor bla = new Vektor(1, 0).mul(jointLength / 2 + 1);
		Vektor pos1 = v.add(bla);
		Vektor pos2 = bla.sub(v);
		Ball ball1 = createBall(pos1);
		Ball ball2 = createBall(pos2);
		join(ball1, ball2);
	}

	/* nur benutzen wenn zwei neue Baelle gejoint werden */
	protected void join(Ball a, Ball b) {
		Joint joint = new Joint(a, b, jointLength, jointStrength);
		a.addJoint(joint);
		b.addJoint(joint);
		joints.add(joint);
	}

	/*
	 * ersetzt einen gleichfarbigen ball im spiel und kuemmert sich um alle
	 * Joints
	 */
	public void replaceBall(Ball a, Ball b) {
		if (!a.isJointWith(b)) {

			for (Joint j : a.getJoints()) {
				if (!b.getJoints().contains(j)) {
					join(b, j.opposite(a));
					joints.remove(j);
				} else {
					b.getJoints().remove(j);
				}
			}
			balls.remove(a);
		}
	}

	private Ball collidingBall(Vektor v) {
		for (Ball b : balls)
			if (b.isHit(v))
				return b; // TODO more than one ball is clicked?
		return null;
	}

	public void restart() {
		balls.clear();
		joints.clear();
	}

	public void mousePressedLeft(Vektor v) {
		Ball b = collidingBall(v);
		if (b != null)
			active = b;
	}

	public void mousePressedRight(Vektor v) {
		createPair(v);
	}

	public void mouseReleasedLeft(Vektor v) {
		active = null;
	}

	public void mouseReleasedRight(Vektor v) {
	}

	public List<Ball> getBalls() {
		return balls;
	}

	public List<Joint> getJoints() {
		return joints;
	}

	private void setFieldSize(double fieldSize) {
		this.fieldSize = fieldSize;
	}

	public double getFieldSize() {
		return fieldSize;
	}

	protected Vektor getPointer() {
		return pointer;
	}
}
