package 
{
	public class Game
	{
		public var width : Number;
		public var height : Number;
		public var fieldSize : Number;
		public var balls : Array;
		public var joints : Array;
		public var pointer : Vektor;
		public var active : Ball;

		private var ballsize:Number = 15;
		private var refreshInterval:Number = 50;
		private var spammer:Spammer;

		private var physics : Physics;
		var enablePhysics:Boolean = true;
		var useGenerateTimer:Boolean  = false;

		private var points:Number = 0;
		private var antipoints:Number = 0;

	
		function initFields() {
			width = 600;
			height = 400;
			fieldSize = 160;
			balls = [];
			joints = [];
			pointer = center;
			spammer = new Spammer(this);
			physics = new Physics(this);
		}
		
		function testSituation() {
			createPair(center.add(new Vektor(100,100)));
		}
		
		function Game() {
			initFields();
			testSituation();
		}
		
		function createBall(v:Vektor):Ball {
			var r = 20;
			var b : Ball = new Ball(v, r);
			b.color = Color.random();
			balls.push(b);
			return b;
		}
		
		// balls below here

		public function createPair(v:Vektor):void {
			var pair:Vektor = Vektor.polar(Math.random() * Math.PI * 2, Joint.defaultLength * 0.6);
			var pos1:Vektor = v.add(pair);
			var pos2:Vektor = v.sub(pair);
			var ball2:Ball = createBall(pos2);
			var ball1:Ball = createBall(pos1);
			joints.push(join(ball1, ball2));
		}

		/* nur benutzen wenn zwei neue Baelle gejoint werden */
		public function join(a:Ball, b:Ball):Joint {
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
		var adistance:Number;
		var bdistance:Number;
		var count:Number = 0;
		var fieldRadius:Number = fieldSize / 2;
		var forfunc = function (j:Joint, i, _) {
			adistance = j.a.position.sub(center).length;
			bdistance = j.b.position.sub(center).length;
			if (adistance < fieldRadius || bdistance < fieldRadius)
				count++;
		}
		joints.forEach(forfunc);
		return count;
	}

	/* balls below here */
	protected function unJoin(a:Ball, b:Ball):void {
		var forfunc = function (j:Joint, i, _){
			joints.remove(j);
			a.removeJoint(j);
			b.removeJoint(j);
		}
		a.jointsWith(b).forEach(forfunc);
	}

	public function attachBalls(c:Collision):void {
		var a:Ball = c.a;
		var b:Ball = c.b;
		if ((a == active || b == active) && c.overlap > 4) {
			if (a.joints.size() > 0 && b.joints.size() > 0) {
				if (a.match(b)) {
					replaceBall(a, b);
					handleCycles();
				}
			} else {
				joints.add(join(a, b));
			}
		}
	}

	private function replaceBall(a:Ball, b:Ball) {
		var shareJointBall:Boolean = false;
		var forfunc = function (jp:Ball, i, _) {
			if (jp.isJointWith(b))
				shareJointBall = true;
		}
		a.jointBalls().forEach(forfunc);
		
		if (!shareJointBall && !a.isJointWith(b)) {
			var forfunc2 = function (jb:Ball, i, _) {
				if (!a.isJointWith(jb)) {
					joints.add(join(a, jb));
				}
			}
			b.jointBalls().forEach(forfunc2);
			removeBall(b);
			active = null;
		}
	}

	private function handleCycles():void {
		var b:Ball;
		var cycle:Array;
		var cycles:Array = CycleTest.cycleTest(balls);
		for (var i = 0; i < cycles.length; i++) {
			cycle = cycles[i];
			for (var j = 0; j > cycle.length; j++) {
				b = cycle[j];
				removeBall(b);
				incPoints();
			}
		}
	}

	private function collidingBall(v:Vektor):Ball  {
		for (var i = 0; i < balls.length; i++) {
			var b:Ball = balls[i];
			if (b.isHit(v))
				return b;
		}
		return null;
	}

	private function removeBall(b:Ball):void {
		joints.removeAll(b.joints);
		for (var i = 0; i < b.jointBalls.length; i++) {
			var jp:Ball;
			jp.joints.removeAll(jp.jointsWith(b));
		}
		balls.remove(b);
	}

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
	public function pointerMoved(v:Vektor) {
		pointer = v;
	}

	public function pointerPressedLeft(v:Vektor) {
		var b:Ball = collidingBall(v);
		if (b != null) {
			active = b;
		}
	}

	public function pointerPressedRight(v:Vektor) {
		createPair(v);
	}

	public function pointerReleasedLeft(v:Vektor) {
		active = null;
	}

	public function pointerReleasedRight(v:Vektor):void {
	}

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

	public function get center():Vektor {
		return new Vektor(width / 2, height / 2);
	}
	
	//protected Vektor getPointer() {
		//return pointer;
	//}
//

//
	//public void setPointer(Vektor pointer) {
		//this.pointer = pointer;
	//}

	public function incPoints():void {
		points++;
	}

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