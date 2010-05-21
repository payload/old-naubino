package 
{
	import fl.motion.Color;
	import flash.display.Sprite;
	
	// TODO no Sprite?
	public class Ball extends Sprite {
		public var position : Vektor;
		public var speed : Vektor;
		public var acceleration : Vektor;
		public var physicalRadius : Number;
		public var visibleRadius : Number;
		public var mass : Number;
		public var color : Color; // TODO: should be in another class
		private var _joints : Array;

		public function get joints() : Array {
			return _joints;
		}
		
		public function Ball(position:Vektor, radius:Number) {
			initFields(position, radius);
		}
		
		private function initFields(position:Vektor, radius:Number) {
			this.position = position;
			x = position.x;
			y = position.y;
			this.physicalRadius = radius;
			this.visibleRadius = radius - 2;
			this.mass = 1;
			speed = new Vektor();
			acceleration = new Vektor();
			//color = Color.random();
			color = new Color(1, 0, 0);
			_joints = [];
		}
		
				/* position and movement below here */
		
		public function accelerate(v:Vektor) {
			acceleration = acceleration.add(v);
		}

		public function isHit(v:Vektor) : Boolean {
			var distance = v.sub(position).length();
			return distance <= physicalRadius;
		}

		public function distanceTo(v:Vektor) : Vektor {
			return v.sub(position);
		}
		
		/* joint stuff below here */

		public function addJoint(joint:Joint) {
			joints.push(joint);
		}

		public function removeJoint(j:Joint) {
			var i = joints.indexOf(j);
			joints.splice(i, 1);
		}

		public function isJointWith(b:Ball) : Boolean {
			var result = false;
			var func = function (j:Joint) {
				if (j.opposite(this) == b)
					result = true;
			};
			joints.forEach(func);
			return result;
		}
		
		public function jointsWith(b:Ball) : Array {
			var withB : Array = [];
			var func = function (j:Joint) {
				if (j.a == b || j.b == b)
					withB.push(j);
			};
			joints.forEach(func);
			return withB;
		}

		public function resetJoints() {
			joints.splice(0, joints.length);
		}

		public function jointBalls() : Array {
			var list = [];
			var func = function (j:Joint) {
				list.add(j.opposite(this));
			}
			joints.forEach(func);
			return list;
		}

		// TODO equals -> color == color
		
		/* getter/setter below here */
		
		

		// drawing
		
		function draw() : void {
			graphics.beginFill(color.color);
			graphics.drawCircle(10, 10, 20);
			graphics.endFill();
		}
		
		public function update(dt : Number) : void {
			
		}
	}
}
	