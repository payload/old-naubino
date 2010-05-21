package 
{

	public class Game
	{
		var width : Number;
		var height : Number;
		var center : Vektor;
		var fieldSize : Number;
		var balls : Array;
		var joints : Array;
		var pointer : Vektor;
		var active : Ball;
		
		function initFields() {
			width = 600;
			height = 400;
			center = new Vektor(width / 2, height / 2);
			fieldSize = 160;
			balls = [];
			joints = [];
			pointer = center;
		}
		
		function Game() {
			initFields();
			createPair();
		}
		
		function createBall() {
			var r = 20;
			var pos = center;
			var b : Ball = new Ball(pos, r);
			b.color = Color.random();
			balls.push(b);
		}
		
		// balls below here

	protected void createPair(Vektor v) {
		Vektor pair = new Vektor(1, 0).mul(Joint.defaultLength * 0.6);
		pair.setAngle(rand.nextDouble() * Math.PI * 2);
		Vektor pos1 = v.add(pair);
		Vektor pos2 = v.sub(pair);
		Ball ball1 = createBall(pos1);
		Ball ball2 = createBall(pos2);
		 if (balls.size() % 4 == 0)
		joints.add(join(ball1, ball2));
	}

	/* nur benutzen wenn zwei neue Baelle gejoint werden */
	protected Joint join(Ball a, Ball b) {
		Joint joint = new Joint(a, b);
		a.addJoint(joint);
		b.addJoint(joint);
		return joint;
	}
	}
	

	//private Physics physics;
	//public Ball active;
	//public boolean enablePhysics = true;
	//public boolean useGenerateTimer = false;
//
	//private int points = 0;
	//private int antipoints = 0;
//
	///* game settings and magic numbers below here */
//
	//private double fieldSize = 320;
	//public int width = 600;
	//public int height = 400;
	//private float ballsize = 15;
	//private int refreshInterval = 50;
//
	//private Random rand = new Random();
	//private Spammer spammer = new Spammer(this);
//
	//private Timer calcTimer;
	//private TimerTask calculate = new TimerTask() {
		//public void run() {
			//refresh();
		//}
	//};
//
	//private Timer generateTimer;
	//private TimerTask generatePairs = new TimerTask() {
		//public void run() {
			//if (useGenerateTimer)
				//spammer.randomPair();
		//}
	//};
//
	//private Game() {
		//balls = new CopyOnWriteArrayList<Ball>();
		//joints = new CopyOnWriteArrayList<Joint>();
		//pointer = getCenter();
		//physics = new Physics(this);
//
		//calcTimer = new Timer();
		//calcTimer.schedule(calculate, 0, refreshInterval);
//
		//generateTimer = new Timer();
		//generateTimer.schedule(generatePairs, 1000, 3 * 1000);
	//}
//
	//public static Game instance() {
		//return instance;
	//}
//
	///* game logic below here */
	//public void refresh() {
		//if (enablePhysics)
			//physics.physik();
		//antipoints = countingJoints();
		//if (antipoints > 30) {
			//restart();
			//useGenerateTimer = false;
		//}
	//}
//
	//public void restart() {
		//balls.clear();
		//joints.clear();
//
	//}
//
	//private int countingJoints() {
		//int count = 0;
		//double fieldRadius = fieldSize / 2;
		//for (Joint j : joints) {
			//double adistance = j.a.position.sub(getCenter()).getLength();
			//double bdistance = j.b.position.sub(getCenter()).getLength();
			//if (adistance < fieldRadius || bdistance < fieldRadius)
				//count++;
		//}
		//return count;
	//}
//
	///* balls below here */
//

//
	//protected void unJoin(Ball a, Ball b) {
		//for (Joint j : a.jointsWith(b)) {
			//joints.remove(j);
			//a.removeJoint(j);
			//b.removeJoint(j);
		//}
	//}
//
	//public void attachBalls(Collision c) {
		//Ball a = c.a;
		//Ball b = c.b;
		//if ((a == active || b == active) && c.overlap > 4) {
			//if (a.getJoints().size() > 0 && b.getJoints().size() > 0) {
				//if (a.equals(b)) {
					//replaceBall(a, b);
					//handleCycles();
				//}
			//} else {
				//joints.add(join(a, b));
			//}
		//}
	//}
//
	//private void replaceBall(Ball a, Ball b) {
		//boolean shareJointBall = false;
		//for (Ball jp : a.jointBalls()) {
			//if (jp.isJointWith(b))
				//shareJointBall = true;
		//}
		//if (!shareJointBall && !a.isJointWith(b)) {
			//for (Ball jb : b.jointBalls()) {
				//if (!a.isJointWith(jb)) {
					//joints.add(join(a, jb));
				//}
			//}
			//removeBall(b);
			//active = null;
		//}
//
	//}
//
	//private void handleCycles() {
		//List<List<Ball>> cycles = CycleTest.cycleTest(balls);
		//for (List<Ball> cycle : cycles)
			//for (Ball b : cycle) {
				//removeBall(b);
				//incPoints();
			//}
	//}
//
	//private Ball collidingBall(Vektor v) {
		//for (Ball b : balls)
			//if (b.isHit(v))
				//return b; // TODO more than one ball is clicked?
		//return null;
	//}
//
	//protected void removeBall(Ball b) {
		//joints.removeAll(b.getJoints());
		//for (Ball jp : b.jointBalls()) {
			//jp.getJoints().removeAll(jp.jointsWith(b));
		//}
		//balls.remove(b);
	//}
//
	///* interaction below here */
	//public void keyPressed(int key) {
		//switch (key) {
		//case 0:
			//spammer.randomPair();
			//break;
		//case 1:
			//restart();
			//break;
		//case 2:
			//
		//case 3:
			//enablePhysics = !enablePhysics;
			//break;
		//case 4:
			//useGenerateTimer = !useGenerateTimer;
			//break;
		//}
	//}
//
	//public void mouseMoved(Vektor v) {
		//setPointer(v);
	//}
//
	//public void mousePressedLeft(Vektor v) {
		//Ball b = collidingBall(v);
		//if (b != null) {
			//active = b;
		//}
	//}
//
	//public void mousePressedRight(Vektor v) {
		//createPair(v);
	//}
//
	//public void mouseReleasedLeft(Vektor v) {
		//active = null;
	//}
//
	//public void mouseReleasedRight(Vektor v) {
	//}
//
	///* getter/setter below here */
	//public List<Ball> getBalls() {
		//return balls;
	//}
//
	//public List<Joint> getJoints() {
		//return joints;
	//}
//
	//public double getFieldSize() {
		//return fieldSize;
	//}
//
	//public int getNumberOfJoints() {
		//return joints.size();
	//}
//
	//protected Vektor getPointer() {
		//return pointer;
	//}
//
	//public Vektor getCenter() {
		//return new Vektor(width / 2, height / 2);
	//}
//
	//public void setPointer(Vektor pointer) {
		//this.pointer = pointer;
	//}
//
	//public void incPoints() {
		//this.points++;
	//}
//
	//public int getPoints() {
		//return points;
	//}
//
	//public int getAntiPoints() {
		//return antipoints;
	//}
//}

	
}