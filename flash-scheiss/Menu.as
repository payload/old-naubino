package 
{
	public class Menu
	{
		var buttons:Array = [];
		var menubutton:Button;
		var play:Button ;
		var pause:Button;
		var mute:Button;
		var highscore:Button;
		var joints:Array = [];
		
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
		
		
		private function initButtons() {
			menubutton = new Button(new Vektor(35, 30), function () { trace("hallo"); } );
			play = new Button(new Vektor(70, 30), function () { trace("play"); } );
			pause = new Button(new Vektor(35, 60), function() { trace("pause"); } );
			mute = new Button(new Vektor(95, 30), function() { trace("mute"); } );
			highscore = new Button(new Vektor(55, 55), function() { trace("highscore"); } );
		}
		
		public function join(a:Button, b:Button):Joint {
			var joint:Joint  = new Joint(a, b);
			a.addJoint(joint);
			b.addJoint(joint);
			return joint;
		}

	}
	
}