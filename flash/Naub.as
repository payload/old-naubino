package 
{
	public class Naub extends Circle {
		private var _joints : Array;

		protected const defaultRadius:Number = 15;
	
		public function get joints() : Array {
			return _joints;
		}
		
		public function Naub(position:Vektor, radius:Number = defaultRadius) {
			initFields(position, radius);
		}
		
		private function initFields(position:Vektor, radius:Number):void {
			this.position = position;
			this.attractedTo = position;
			this.radius = radius;
			this.visibleRadius = radius - 2;
			this.mass = 1;
			speed = new Vektor();
			acceleration = new Vektor();
			_joints = [];
		}
	
		/* joint stuff below here */

		public function addJoint(joint:Joint):void {
			joints.push(joint);
		}

		public function removeJoint(j:Joint):void {
			var i:int = joints.indexOf(j);
			joints.splice(i, 1);
		}

		public function isJointWith(b:Naub) : Boolean {
			var result:Boolean = false;
			for (var i:uint = 0; i < joints.length; i++) {
				var j:Joint = joints[i];
				if (j.opposite(this) == b)
					result = true;
				}
			return result;
		}
		
		public function jointsWith(b:Naub) : Array {
			var withB : Array = [];
			for(var i:uint = 0; i < joints.length; i++) {
				var j:Joint = joints[i];
				if (j.a == b || j.b == b)
					withB.push(j);
			};
			return withB;
		}

		public function resetJoints():void {
			joints.splice(0, joints.length);
		}

		public function jointNaubs() : Array {
			var list:Array = [];
			for (var i:uint = 0; i < joints.length; i++) {
				var j:Joint = joints[i];
				list.push(j.opposite(this));
			}
			return list;
		}

		public function matches(o:Naub):Boolean {
			return color == o.color;
		}
	}
}
	