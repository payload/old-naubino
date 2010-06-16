package {
	public class Circle extends Physical implements Action {
		public var color:Color = Color.random;

		private var _action:Function = function():void{};

		public function isHit(v:Vektor) : Boolean {
			var distance:Number = v.sub(position).length;
			return distance <= visibleRadius;
		}
		
		public function setAction(action:Function):void {
			_action = action;
		}
		
		public function action():void {
			_action();
		}

		public function get visibleRadius():Number {
			return max(radius - 2, 0);
		}

		public function set visibleRadius(r:Number):void  {
			radius = r + 2;
		}

		private function max(a:*, b:*):* {
			if (a < b)
				return b;
			else
				return a;
		}
	}
}
