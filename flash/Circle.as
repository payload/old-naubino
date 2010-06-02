package {
	public class Circle extends Physical implements Action {
		public var visibleRadius:Number = 15.0;
		public var color:Color = Color.random();

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
	}
}