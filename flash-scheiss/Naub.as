package 
{
	public class Naub {
		public var position : Vektor;
		public var speed : Vektor;
		public var acceleration : Vektor;
		public var physicalRadius : Number;
		public var visibleRadius : Number;
		public var mass : Number;
		public var color : Color;
		private var _joints : Array;
		public var attracted:Boolean;
		public var attractedTo:Vektor;
		
		protected const defaultRadius = 15;

		public function get joints() : Array {
			return _joints;
		}
		
		public function Naub(position:Vektor, radius:Number = defaultRadius) {
			initFields(position, radius);
		}
		
		private function initFields(position:Vektor, radius:Number) {
			this.position = position;
			this.attractedTo = position;
			this.physicalRadius = radius;
			this.visibleRadius = radius - 2;
			this.mass = 1;
			speed = new Vektor();
			acceleration = new Vektor();
			color = Color.random();
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

		public function isJointWith(b:Naub) : Boolean {
			var result = false;
			for (var i = 0; i < joints.length; i++) {
				var j:Joint = joints[i];
				if (j.opposite(this) == b)
					result = true;
				}
			return result;
		}
		
		public function jointsWith(b:Naub) : Array {
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

		public function jointNaubs() : Array {
			var list = [];
			for (var i = 0; i < joints.length; i++) {
				var j:Joint = joints[i];
				list.push(j.opposite(this));
			}
			return list;
		}

		public function matches(o:Naub):Boolean {
			return color == o.color;
		}
		
		public function action():void {
			
		}
	}
}
	