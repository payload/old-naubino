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

	private Timer calcTimer;
	private TimerTask calculate = new TimerTask() {
		public void run() {
			refresh();
		}
	};
	private Timer generateTimer;
	private TimerTask generatePairs = new TimerTask(){
		public void run() {
			randomPair();
		}
	};

	private Game() {
		balls = new CopyOnWriteArrayList<Ball>();
		joints = new CopyOnWriteArrayList<Joint>();
		pointer = getCenter();
		physics = new Physics(this);

		calcTimer = new Timer();
		calcTimer.schedule(calculate, 0, refreshInterval);
		generateTimer = new Timer();
//		generateTimer.schedule(generatePairs, 1000, 6*1000);
		
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

	public void randomPair() {
		Vektor randPos;

		double xMargin = height / 2 - fieldSize / 2;
		double yMargin = width / 2 - fieldSize / 2;
		switch (rand.nextInt(3)) {
		case 0:
			randPos = new Vektor(rand.nextDouble() * xMargin, rand.nextDouble() * yMargin);
			System.out.println("oben links");
			break;
		case 1:
			randPos = new Vektor(width - rand.nextDouble() * xMargin, rand.nextDouble() * yMargin);
			System.out.println("oben rechts");
			break;
		case 2:
			randPos = new Vektor(rand.nextDouble() * xMargin, height - rand.nextDouble() * yMargin);
			System.out.println("unten links");
			break;
		case 3:
			randPos = new Vektor(width - rand.nextDouble() * xMargin, height - rand.nextDouble() * yMargin);
			System.out.println("unten rechts");
			break;
		default:
			randPos = new Vektor(width - rand.nextDouble() * xMargin, height - rand.nextDouble() * yMargin);
			System.out.println("unten rechts");
			break;
		}
		createPair(randPos);
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
			for (Joint j : b.getJoints()) {
				if (!a.getJoints().contains(j)) {
					join(a, j.opposite(b));
					joints.remove(j);
				} else {
					a.getJoints().remove(j);
				}
			}
			balls.remove(b);
			active = null;
		}
		/* remove joints that link nowhere */
		for (Joint j : joints) {
			/* delete obsolete */
			for (Joint k : joints) {
				if (j != k && j.equals(k))
					joints.remove(j);
			}
			/* delete one-balled joints */
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
