package 
{
	import caurina.transitions.Tweener;
	public class Ball extends Naub
	{
		public var active:Boolean = false;
		public var attacheAction:Function;
		public var removeAction:Function;
		
		
		public override function action():void {
			active = true;
		}
		
		public function release():void {
			active = false;
		}
		
		public function onAttach():void {
			if(attacheAction == null)
				trace("onAttach");
			else
				attacheAction();
		}
		
		public function attachedButRemoved():void {
			//trace("attachedButRemoved");
		}
		
		public function onRemove():void{
			if(attacheAction == null)
				trace("onRemove");
			else
				removeAction();
		}
		
		public function Ball(pos:Vektor, r:Number=defaultRadius) {
			super(pos, r);
			attracted = true;
		}
	}
}
