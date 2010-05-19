import java.util.*;
import java.util.concurrent.*;

public class Game {

	private static final Game instance = new Game();
	protected static List<Ball> balls;
	protected static List<Joint> joints;
	private Vektor pointer;
	private Physics physics;
	public static Ball active;


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
//		balls = new ArrayList<Ball>();
		joints = new CopyOnWriteArrayList<Joint>();
//		joints = new ArrayList<Joint>();
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
	}

	public void restart() {
		balls.clear();
		joints.clear();

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
		// if (balls.size() % 4 == 0)
		joints.add(join(ball1, ball2));
	}

	/* nur benutzen wenn zwei neue Baelle gejoint werden */
	protected static Joint join(Ball a, Ball b) {
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
		Ball a = c.a;
		Ball b = c.b;
		Vektor diff = a.position.sub(b.position);
		double overlap = a.radius + b.radius - diff.getLength();
		if ((a == active || b == active)) {
			if (a.getJoints().size() > 0 && b.getJoints().size() > 0) {	
				if (a.equals(b) && (overlap > 0)) {
					replaceBall(a, b);
					refresh();
				}
			} else {
				joints.add(join(a, b));
			}
		}
		cycleTest.cycleTest();
	}

	private void replaceBall(Ball a, Ball b) {
		if (!a.isJointWith(b)) {
			for (Ball jb : b.jointBalls()) {
				if (!a.isJointWith(jb)) {
					joints.add(join(a, jb));
				}
			}
			removeBall(b);
			active = null;
		}

	}

	private Ball collidingBall(Vektor v) {
		for (Ball b : balls)
			if (b.isHit(v))
				return b;
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
	public static List<Ball> getBalls() {
		return balls;
	}

	public static List<Joint> getJoints() {
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
	
	public static Ball getActiveBall(Ball a, Ball b){
		if(active == a || active == b)
			return active;
		else
			return null;
	}
}
