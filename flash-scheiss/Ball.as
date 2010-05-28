package 
{
	public class Ball {
		public var position : Vektor;
		public var speed : Vektor;
		public var acceleration : Vektor;
		public var physicalRadius : Number;
		public var visibleRadius : Number;
		public var mass : Number;
		public var color : Color;
		private var _joints : Array;

		public function get joints() : Array {
			return _joints;
		}
		
		public function Ball(position:Vektor, radius:Number) {
			initFields(position, radius);
		}
		
		private function initFields(position:Vektor, radius:Number) {
			this.position = position;
			this.physicalRadius = radius;
			this.visibleRadius = radius - 2;
			this.mass = 1;
			speed = new Vektor();
			acceleration = new Vektor();
			color = Color.random();
			//color = 0xFF0000;
			_joints = [];
		}
		
				/* position and movement below here */
		
		public function accelerate(v:Vektor) {
			acceleration = acceleration.add(v);
		}

		public function isHit(v:Vektor) : Boolean {
			var distance = v.sub(position).length;
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
			var func = function (j:Joint, i, _) {
				if (j.opposite(this) == b)
					result = true;
			};
			joints.forEach(func);
			return result;
		}
		
		public function jointsWith(b:Ball) : Array {
			var withB : Array = [];
			var func = function (j:Joint, i, _) {
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
			var func = function (j:Joint, i, _) {
				list.add(j.opposite(this));
			}
			joints.forEach(func);
			return list;
		}

		public function match(o:Ball):Boolean {
			return color == o.color;
		}
	}
}
	