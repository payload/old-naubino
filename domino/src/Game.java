import java.util.ArrayList;
import java.util.Collection;
import java.util.ConcurrentModificationException;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;

public class Game {

	private static final Game instance = new Game();
	private List<Ball> balls;
	private List<Joint> joints;
	private float fieldSize;
	public Ball active;
	public int width = 600;
	public int height = 400;
	private float ballsize = 60;
	private int refreshInterval = 50;

	public Coord getCenter() {
		return new Coord(width / 2, height / 2);
	}

	public int getNumberOfJoints() {
		return joints.size();
	}

	private Timer timer;
	private TimerTask task = new TimerTask() {
		public void run() {
			try {
				refresh();
				// TODO occasionally throws ConcurrentModificationException
			} catch (ConcurrentModificationException e) {
				balls = new ArrayList<Ball>();
				joints = new ArrayList<Joint>();
				System.out.println("how did I handle that ?!");
			}
		}

	};

	private Game() {
		balls = new ArrayList<Ball>();
		joints = new ArrayList<Joint>();
		setFieldSize(320f);
		timer = new Timer();
		timer.schedule(task, 0, refreshInterval);
	}

	public static Game instance() {
		return instance;
	}

	public void refresh() {
		physik();
	}

	public void physik() {
		for (Ball b : balls) {
			// gravitation
			b.acceleration = new rVektor(b.position, getCenter(), 5 / b	.distanceTo(getCenter()).getLength());

			List<Ball> templist = balls;
			for (Ball o : templist) {
				float dx = o.getX() - b.getX();
				float dy = o.getY() - b.getY();
				double distance = Math.sqrt(Math.pow(dx,2) + Math.pow(dy,2));
				float sonstwas;
				 if (o != b && distance <= 30){
					 o.acceleration.add(new rVektor(o.position, b.position, distance));
				 }
				// b.acceleration.add(o.distanceTo(b));
			}

			/* change speed */
			b.speed.add(b.acceleration);
			/* actually move */
			b.position = b.position.add(b.speed);
			b.acceleration = new rVektor();
		}
	}

	public void setFieldSize(float fieldSize) {
		this.fieldSize = fieldSize;
	}

	public float getFieldSize() {
		return fieldSize;
	}

	public List<Ball> getBalls() {
		return balls;
	}

	public List<Joint> getJoints() {
		return joints;
	}

	public Ball getBall(int index) {
		return balls.get(index);
	}

	private Ball createBall(float x, float y) {
		Ball ball = new Ball(x, y, ballsize);
		ball.color = randomColor();
		balls.add(ball);
		return ball;
	}

	public void createPair(float x, float y) {
		join(createBall(x - 20, y - 20), createBall(x + 20, y + 20));
	}

	public void createTriple(float x, float y) {
		Ball a = createBall(x + 20, y - 20);
		Ball b = createBall(x - 20, y - 20);
		Ball c = createBall(x, y + 20);
		join(a, b);
		join(b, c);
		// join(c, a);
	}

	private void join(Ball a, Ball b) {
		Joint joint = new Joint(a, b);
		a.addJoint(joint);
		b.addJoint(joint);
		joints.add(joint);
	}

	/* gibt eine zufällige Farbe aus dem OUTPUT farbschema zurück */
	private Color randomColor() {
		List<Color> list = new ArrayList<Color>();
		Color red = new Color(229, 53, 23, "red");
		Color green = new Color(151, 190, 13, "green");
		Color pink = new Color(226, 0, 122, "pink");
		Color blue = new Color(0, 139, 208, "blue");
		Color purple = new Color(100, 31, 128, "purple");
		Color yellow = new Color(255, 204, 0, "yellow");

		list.add(red);
		list.add(green);
		list.add(pink);
		list.add(blue);
		list.add(purple);
		list.add(yellow);

		Random rand = new Random();

		return list.get(rand.nextInt(list.size()));
	}

	public Ball clickedBall(float x, float y) {
		for (Ball b : balls) {
			if (b.isHit(new Coord(x, y))) {
				this.active = b;
				return b;
			}
		}
		return null;
	}

	public void checkForHits(float x, float y) {
		for (Ball b : balls) {
			if (b.isHit(new Coord(x, y))) {
				b.color = new Color(0, 0, 255);
			}
		}
	}

	public Ball checkForCollisions(Ball active) {
		for (Ball b : balls) {
			float distance = (float) Math.sqrt(Math.pow(b.getX()
					- active.getX(), 2)
					+ Math.pow(b.getY() - active.getY(), 2));

			/* TODO Collisionen mit sich selbst schoener vermeiden */
			if (distance > 0 && distance <= ballsize
					&& b.color.name == active.color.name) {
				return b;
			}
		}
		return null;
	}

	/* deletes all balls */
	public void resetBalls() {
		balls = new ArrayList<Ball>();
	}

	/* deletes all joints */
	public void resetJoints() {
		joints = new ArrayList<Joint>();
	}

	/* deletes orphaned joints */
	public void cleanUpJoints() {
		for (Joint j : joints) {
			if (j.a == null || j.b == null)
				joints.remove(j);
		}
	}

	/* anstaendige Move funktion einfuegen */
	public void dragActive(float x, float y) {

		if (active != null) {
			active.move(x, y);
			Ball collidor = checkForCollisions(active);

			// if (collidor != null) {
			// active.resetJoints();
			// balls.remove(active);
			// removeBall(active);
			// join(taily, collidor);
			// }
		}
	}

}
