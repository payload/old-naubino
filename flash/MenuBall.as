package 
{
	import flash.utils.*;
	import flash.events.*;
	import stat.es.*;
	import caurina.transitions.Tweener;
	public class MenuBall extends Ball
	{
		private var bla:Vektor = new Vektor(250, 250);
		public var game:Game;
		public override function action():void {
			active = true;
			game.visual.hide(game.visual.help.helptext1);
		}
		
		public function MenuBall(pos:Vektor, r:Number=defaultRadius) {
			super(pos, r);
			attracted = true;
		}
		
	}
}
