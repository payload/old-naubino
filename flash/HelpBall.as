package 
{
	import flash.utils.*;
	import flash.events.*;
	import stat.es.*;
	import caurina.transitions.Tweener;
	public class HelpBall extends Ball
	{
		public var onRelease:Function;
		public var onAttached:Function;
		public var onAttachedButRemoved:Function;
		
		private var bla:Vektor = new Vektor(250, 250);
		public var game:Game;
		public override function action():void {
			active = true;
		}
		
		public override function release():void {
			active = false;
			if (onRelease != null)
				onRelease(this);
		}
		
		public override function attached():void {
			if (onAttached != null) onAttached(this);
		}
		
		public override function attachedButRemoved():void {
			if (onAttachedButRemoved != null) onAttachedButRemoved(this);
		}
		
		public function HelpBall(pos:Vektor, r:Number=defaultRadius) {
			super(pos, r);
			attracted = true;
		}
		
	}
}
