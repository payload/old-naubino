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

		private var ballsize:Number = 15;
		private var refreshInterval:Number = 50;
		private var spammer:Spammer;

		//private Physics physics TODO Physics auskommentieren;
		var enablePhysics:Boolean = true;
		var useGenerateTimer:Boolean  = false;

		private var points:Number = 0;
		private var antipoints:Number = 0;

	
		function initFields() {
			width = 600;
			height = 400;
			center = new Vektor(width / 2, height / 2);
			fieldSize = 160;
			balls = [];
			joints = [];
			pointer = center;
			spammer   = new Spammer(this);
		}
		
		function Game() {
			initFields();
			//createPair();
		}
		
		function createBall(v:Vektor) {
			var r = 20;
			var b : Ball = new Ball(v, r);
			b.color = Color.random();
			balls.push(b);
		}
		
		// balls below here

		protected function createPair(v:Vektor) {
			var pair:Vektor = Vektor.polar(Math.random() * Math.PI * 2, Joint.defaultLength * 0.6);
			var pos1:Vektor = v.add(pair);
			var pos2:Vektor = v.sub(pair);
			var ball2:Ball = createBall(pos2);
			var ball1:Ball = createBall(pos1);
			if (balls.size() % 4 == 0)
				joints.add(join(ball1, ball2));
		}

		/* nur benutzen wenn zwei neue Baelle gejoint werden */
		protected function join(a:Ball, b:Ball):Joint {
			var joint:Joint  = new Joint(a, b);
			a.addJoint(joint);
			b.addJoint(joint);
			return joint;
		}
	

	/* game settings and magic numbers below here */


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
//	private Game() {
		//balls = new CopyOnWriteArrayList<Ball>();
		//joints = new CopyOnWriteArrayList<Joint>();
		//pointer = getCenter();
		//physics = new Physics(this);

		//calcTimer = new Timer();
		//calcTimer.schedule(calculate, 0, refreshInterval);

		//generateTimer = new Timer();
		//generateTimer.schedule(generatePairs, 1000, 3 * 1000);
	//}
	
	/* game logic below here */
	public function refresh() {
		if (enablePhysics)
			physics.physik();
		antipoints = countingJoints();
		if (antipoints > 30) {
			restart();
			useGenerateTimer = false;
		}
	}

	public function restart() {
		balls.clear();
		joints.clear();

	}

	private function countingJoints():Number {
		var count:Number = 0;
		var fieldRadius:Number = fieldSize / 2;
		var forfunc = function (j:Joint, i, _){
			adistance:Number = j.a.position.sub(getCenter()).getLength();
			bdistance:Number = j.b.position.sub(getCenter()).getLength();
			if (adistance < fieldRadius || bdistance < fieldRadius)
				count++;
		}
		joints.forEach(forfunc);
		return count;
	}

	/* balls below here */
	protected function unJoin(a:Ball, b:Ball) {
		var forfunc = function (j:Joint, i, _){
			joints.remove(j);
			a.removeJoint(j);
			b.removeJoint(j);
		}
		a.jointsWith(b).forEach(forfunc);
	}

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
	
}