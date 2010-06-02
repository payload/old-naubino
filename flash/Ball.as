package 
{
	import caurina.transitions.Tweener;
	public class Ball extends Naub
	{
		public var active:Boolean = false;
		
		public override function action():void {
			active = true;
		}
		public function Ball(pos:Vektor, r:Number=defaultRadius) {
			super(pos, r);
			attracted = true;
		}

		public function disappear():void{
			var tween:Object = {
				VisualRadius: 0,
				time:0.5
			};
			Tweener.addTween(this,tween);
		}
	}
}