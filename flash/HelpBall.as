package 
{
	import flash.utils.*;
	import flash.events.*;
	import stat.es.*;
	import caurina.transitions.Tweener;
	public class HelpBall extends Ball
	{
		private var bla:Vektor = new Vektor(250, 250);
		public var game:Game;
		public override function action():void {
			active = true;
		}
		
		public override function release():void {
			active = false;
		}
		
		public function HelpBall(pos:Vektor, r:Number=defaultRadius) {
			super(pos, r);
			attracted = true;
		}
		
	}
}
