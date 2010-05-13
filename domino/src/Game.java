import java.util.*;
import java.util.concurrent.*;

public class Game {

	private static final Game instance = new Game();
	protected List<Ball> balls;
	protected List<Joint> joints;
	private Vektor pointer;
	private Physics physics;
	public Ball active;

	/* game settings and magic numbers below here */
	
	private double fieldSize = 320;
	private double jointLength = 40;
	private double jointStrength = 0.1;
	public int width = 600;
	public int height = 400;
	private float ballsize = 15;
	private int refreshInterval = 50;

	private Timer timer;
	private TimerTask task = new TimerTask() {
		public void run() {
			refresh();
		}
	};

	private Game() {
		balls = new CopyOnWriteArrayList<Ball>();
		joints = new CopyOnWriteArrayList<Joint>();
		pointer = getCenter();
		physics = new Physics(this);

		timer = new Timer();
		timer.schedule(task, 0, refreshInterval);
	}

	private static Random rand = new Random();

	public static Game instance() {
		return instance;
	}

	/* game logic below here */

	public void refresh() {
		physics.physik();
	}

	public void restart() {
		balls.clear();
		joints.clear();
	}

	/* balls below here */

	private Ball createBall(Vektor v) {
		Ball ball = new Ball(v, ballsize);
		ball.color = Color.random();
		balls.add(ball);
		return ball;
	}

	private void createPair(Vektor v) {
		Vektor pair = new Vektor(1, 0).mul(jointLength / 2 + 1);
		pair.setAngle(rand.nextDouble() * Math.PI);
		Vektor pos1 = v.add(pair);
		Vektor pos2 = pair.sub(v);
		Ball ball1 = createBall(pos1);
		Ball ball2 = createBall(pos2);
		join(ball1, ball2);
	}

	protected void join(Ball a, Ball b) {
		Joint joint = new Joint(a, b, jointLength, jointStrength);
		a.addJoint(joint);
		b.addJoint(joint);
		joints.add(joint);
	}

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
			active = null;
		}
		/* remove joints that link nowhere */
		for (Joint j : joints) {
			if (!balls.contains(j.a) || !balls.contains(j.b))
				joints.remove(j);
		}
	}

	private Ball collidingBall(Vektor v) {
		for (Ball b : balls)
			if (b.isHit(v))
				return b; // TODO more than one ball is clicked?
		return null;
	}

	/* mouseinteraction below here */

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

	/* getter/setter below here */

	public List<Ball> getBalls() {
		return balls;
	}

	public List<Joint> getJoints() {
		return joints;
	}

	public double getFieldSize() {
		return fieldSize;
	}

	public int getNumberOfJoints() {
		return joints.size();
	}

	protected Vektor getPointer() {
		return pointer;
	}

	public Vektor getCenter() {
		return new Vektor(width / 2, height / 2);
	}

	public void setPointer(Vektor pointer) {
		this.pointer = pointer;
	}
}
