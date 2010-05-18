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
	public int width = 600;
	public int height = 400;
	private float ballsize = 15;
	private int refreshInterval = 50;

	private Random rand = new Random();
	private Spammer spammer = new Spammer(this);
	private CycleTest cycleTest = new CycleTest(this);

	private Timer calcTimer;
	private TimerTask calculate = new TimerTask() {
		public void run() {
			refresh();
		}
	};

	private boolean useGenerateTimer = false;
	private Timer generateTimer;
	private TimerTask generatePairs = new TimerTask() {
		public void run() {
			spammer.randomPair();
		}
	};

	private Game() {
		balls = new CopyOnWriteArrayList<Ball>();
		joints = new CopyOnWriteArrayList<Joint>();
		pointer = getCenter();
		physics = new Physics(this);

		calcTimer = new Timer();
		calcTimer.schedule(calculate, 0, refreshInterval);

		if (useGenerateTimer) {
			generateTimer = new Timer();
			generateTimer.schedule(generatePairs, 1000, 4 * 1000);
		}
	}

	public static Game instance() {
		return instance;
	}

	/* game logic below here */
	public void refresh() {
		physics.physik();
		cycleTest.cycleTest();
	}

	public void restart() {
		balls.clear();
		joints.clear();

		testGraph();
	}

	public void testGraph() {
		Ball a = new Ball(pointer, ballsize);
		Ball b = new Ball(pointer.sub(Vektor.polar(Math.PI / 2, 50)), ballsize);
		Ball c = new Ball(pointer.sub(Vektor.polar(Math.PI, 50)), ballsize);
		Ball d = new Ball(pointer.sub(Vektor.polar(Math.PI * 1.5, 50)), ballsize);
		Ball e = new Ball(pointer.sub(Vektor.polar(Math.PI * 2, 50)), ballsize);

		balls.add(a);
		a.color = Color.blue;
		balls.add(b);
		b.color = Color.green;
		balls.add(c);
		c.color = Color.red;
		balls.add(d);
		d.color = Color.blue;
		balls.add(e);
		e.color = Color.green;

		joints.add(join(a, b));
		joints.add(join(b, c));
		joints.add(join(c, d));
		joints.add(join(d, e));

	}

	/* balls below here */

	private Ball createBall(Vektor v) {
		Ball ball = new Ball(v, ballsize);
		// ball.color = Color.random();
		balls.add(ball);
		return ball;
	}

	protected void createPair(Vektor v) {
		Vektor pair = new Vektor(1, 0).mul(Joint.defaultLength * 0.6);
		pair.setAngle(rand.nextDouble() * Math.PI * 2);
		Vektor pos1 = v.add(pair);
		Vektor pos2 = v.sub(pair);
		Ball ball1 = createBall(pos1);
		Ball ball2 = createBall(pos2);
		joints.add(join(ball1, ball2));
	}

	/* nur benutzen wenn zwei neue Baelle gejoint werden */
	protected Joint join(Ball a, Ball b) {
		Joint joint = new Joint(a, b);
		a.addJoint(joint);
		b.addJoint(joint);
		return joint;
	}

	protected void unJoin(Ball a, Ball b) {
		for (Joint j : a.jointsWith(b)) {
			joints.remove(j);
			a.removeJoint(j);
			b.removeJoint(j);
		}
	}

	public void attachBalls(Collision c) {
		if ((c.a == active || c.b == active) && c.a.color.equals(c.b.color)) {
			Ball a = c.a; Ball b = c.b;
			if (a.getJoints().size() > 0 && b.getJoints().size() > 0) {
				if (!a.isJointWith(b)) { // a haengt nicht an b
					for (Ball jb : b.jointBalls()) { // alle anhaenger an b
						if (!a.isJointWith(jb)) { // anhaenger haengt nicht
													// bereits
							// an a
							joints.add(join(a, jb));
						}
					}
					removeBall(b);
					active = null;
				}
			} else
				joints.add(join(a, b));
		}
	}

	private Ball collidingBall(Vektor v) {
		for (Ball b : balls)
			if (b.isHit(v))
				return b; // TODO more than one ball is clicked?
		return null;
	}

	protected void removeBall(Ball b) {
		joints.removeAll(b.getJoints());
		for (Ball jp : b.jointBalls()) {
			jp.getJoints().removeAll(jp.jointsWith(b));
		}
		balls.remove(b);
	}

	/* interaction below here */
	public void keyPressed(int key) {
		switch (key) {
		case 0:
			spammer.randomPair();
			break;
		case 1:
			restart();
			break;
		case 2:
			cycleTest.removeBlack();
		}
	}

	public void mouseMoved(Vektor v) {
		setPointer(v);
	}

	public void mousePressedLeft(Vektor v) {
		Ball b = collidingBall(v);
		if (b != null) {
			active = b;
		}
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
