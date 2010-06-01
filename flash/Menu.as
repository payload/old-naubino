package 
{
	public class Menu
	{
		public var buttons:Array = [];
		public var menubutton:Button;
		public var play:Button ;
		public var pause:Button;
		public var mute:Button;
		public var highscore:Button;
		public var joints:Array = [];
		
		public function Menu() {
			initButtons();
			buttons.push(menubutton);
			buttons.push(play);
			buttons.push(pause);
			buttons.push(mute);
			buttons.push(highscore);
			
			joints.push(join(menubutton, pause));
			joints.push(join(menubutton, play));
			joints.push(join(play, mute));
			joints.push(join(pause, highscore));
			
		}
		
		
		private function initButtons():void {
			menubutton = new Button(new Vektor(35, 30), function ():void { trace("hallo"); } );
			play = new Button(new Vektor(70, 30), function ():void { trace("play"); } );
			pause = new Button(new Vektor(35, 60), function ():void { trace("pause"); } );
			mute = new Button(new Vektor(95, 30), function ():void { trace("mute"); } );
			highscore = new Button(new Vektor(55, 55), function ():void { trace("highscore"); } );
		}
		
		public function join(a:Button, b:Button):Joint {
			var joint:Joint  = new Joint(a, b);
			a.addJoint(joint);
			b.addJoint(joint);
			return joint;
		}

	}
	
}