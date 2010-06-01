package 
{
	import flash.display.JointStyle;
	import flash.utils.Timer;
	public class Game
	{
		public const width : Number = 600;
		public const height : Number = 400;
		public var fieldSize : Number;
		public var balls : Array;
		public var joints : Array;
		public var pointer : Vektor;
		public var menu : Menu;

		private var refreshInterval:Number = 50;
		public var spammer:Spammer;

		private var physics : Physics;
		public var enablePhysics:Boolean = true;
		public var useGenerateTimer:Boolean  = false;

		private var points:Number = 0;
		private var antipoints:Number = 0;

		private function initFields():void {
			fieldSize = 160;
			balls = [];
			joints = [];
			pointer = center;
			spammer = new Spammer(this);
			physics = new Physics(this);
			menu = new Menu();
			
			utils.addAll(balls, menu.buttons);
		}
		
		public function Game() {
			initFields();
		}
		
		public function createBall(v:Vektor = null):Ball {
			if (v == null) v = Vektor.O;
			var b : Ball = new Ball(v);
			b.attractedTo = center;
			balls.push(b);
			return b;
		}
		
		// balls below here

		public function createPair(v:Vektor):void {
			var ball1:Ball = createBall();
			var ball2:Ball = createBall();
			var joint : Joint = join(ball1, ball2);
			var pair:Vektor = Vektor.polar(Math.random() * Math.PI * 2, joint.length * 0.6);
			var pos1:Vektor = v.add(pair);
			var pos2:Vektor = v.sub(pair);
			ball1.position = pos1;
			ball2.position = pos2;
		  joints.push(joint);
		}

		/* nur benutzen wenn zwei neue Baelle gejoint werden */
		public function join(a:Naub, b:Naub):Joint {
			var joint:Joint  = new Joint(a, b);
			a.addJoint(joint);
			b.addJoint(joint);
			return joint;
		}
	
		/* game logic below here */
		public function refresh():void {
			if (enablePhysics)
				physics.physik();
			antipoints = countingJoints();
			if (antipoints > 30) {
				restart();
				useGenerateTimer = false;
			}
		}

		public function restart():void {
			balls.splice(0, balls.length);
			joints.splice(0, joints.length);
		}

		private function countingJoints():Number {
			var adistance:Number;
			var bdistance:Number;
			var count:Number = 0;
			var fieldRadius:Number = fieldSize / 2;
			for (var i:uint = 0; i < joints.length; i++) {
				var j:Joint = joints[i];
				adistance = j.a.position.sub(center).length;
				bdistance = j.b.position.sub(center).length;
				if (adistance < fieldRadius || bdistance < fieldRadius)
					count++;
			}
			return count;
		}

		/* balls below here */
		protected function unJoin(a:Ball, b:Ball):void {
			var joints:Array = a.jointsWith(b);
			for(var i:uint = 0; i < joints.length; i++) {
				var j:Joint = joints[i];
				joints.remove(j);
				a.removeJoint(j);
				b.removeJoint(j);
			}
		}

		public function attachBalls(c:Collision):void {
			var a:Ball = c.a;
			var b:Ball= c.b;
			if ((a.active || b.active) && c.overlap > 4) {
				if (a.joints.length > 0 && b.joints.length > 0) {
					if ((a is Ball) && (b is Ball) && (a.matches(b))) {
						replaceBall(a, b);
						handleCycles();
					}
				} else {
					joints.push(join(a, b));
				}
			}
		}

		private function replaceBall(a:Ball, b:Ball):void {
			var shareJointBall:Boolean = false;
			var naubs:Array = a.jointNaubs();
			var i:uint;
			var naub:Naub;
			for (i = 0; i < naubs.length; i++) {
				naub = naubs[i];
				if (naub.isJointWith(b))
					shareJointBall = true;
			}
			
			if (!shareJointBall && !a.isJointWith(b)) {
				naubs = b.jointNaubs();
				for (i = 0; i < naubs.length; i++) {
					naub = naubs[i];
					if (!a.isJointWith(naub)) {
						joints.push(join(a, naub));
					}
				}
				removeBall(b);
			}
		}

		private function handleCycles():void {
			var b:Ball;
			var cycle:Array;
			var cycles:Array = CycleTest.cycleTest(balls);
			for (var i:uint = 0; i < cycles.length; i++) {
				cycle = cycles[i];
				for (var j:uint = 0; j < cycle.length; j++) {
					b = cycle[j];
					removeBall(b);
					incPoints();
				}
			}
		}

		private function collidingBall(v:Vektor):Naub  {
			var i:uint;
			for (i = 0; i < balls.length; i++) {
				var ball:Ball = balls[i];
				if (ball.isHit(v))
					return ball;
			}
			for (i = 0; i < menu.buttons.length; i++) {
				var button:Button = menu.buttons[i];
				if (button.isHit(v))
					return button;
			}
			return null;
		}

		private function removeAll(a:Array, b:Array):void {
			for (var i:uint = 0; i < b.length; i++) {
				var j:Joint = b[i];
				a.splice(a.indexOf(j), 1);
			}
		}
		
		private function removeBall(b:Ball):void {
			removeAll(joints, b.joints);
			var jointballs:Array = b.jointNaubs();
			for (var i:uint = 0; i < jointballs.length; i++) {
				var jp:Ball = jointballs[i];
				removeAll(jp.joints, jp.jointsWith(b));
			}
			balls.splice(balls.indexOf(b), 1);
		}

		/* interaction below here */

		public function pointerMoved(v:Vektor):void {
			pointer = v;
		}

		public function pointerPressedLeft(v:Vektor):void {
			var b:Naub = collidingBall(v);
			if (b != null)
				b.action();
		}

		public function pointerPressedRight(v:Vektor):void {
			createPair(v);
		}

		public function pointerReleasedLeft(v:Vektor):void {
			for (var i:uint = 0; i < balls.length; i++)
				balls[i].active = false;
		}

		public function pointerReleasedRight(v:Vektor):void {
		}

		public function get center():Vektor {
			return new Vektor(width / 2, height / 2);
		}
		
		public function get active():Ball {
			for (var i:uint = 0; i < balls.length; i++)
				if (balls[i].active)
					return balls[i];
			return null;
		}
		
		public function incPoints():void {
			points++;
		}

	}
	
}