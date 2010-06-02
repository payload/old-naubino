package {
	import caurina.transitions.Tweener;
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
		public function disappear():void{
			var tween:Object = {
				radius: 0,
				alpha: 0.5,
				time:0.5
			};
			Tweener.addTween(this,tween);
		}
	}
}