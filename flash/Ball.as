package 
{
	import caurina.transitions.Tweener;
	public class Ball extends Naub
	{
		public var active:Boolean = false;
		
		
		public override function action():void {
			active = true;
		}
		
		public function release():void {
			active = false;
		}
		
		public function onAttach():void {
			trace("onAttach");
		}
		
		public function attachedButRemoved():void {
			trace("attachedButRemoved");
		}
		
		public function onRemove():void{
			trace("onRemove");
		}
		
		public function Ball(pos:Vektor, r:Number=defaultRadius) {
			super(pos, r);
			attracted = true;
		}
	}
}
