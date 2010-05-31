package 
{
	public class Menu
	{
		var buttons:Array = [];
		var play:Button ;
		var pause:Button;
		var mute:Button;
		var highscore:Button;
		var joints:Array = [];
		
		public function Menu() {
			buttons.push(new Button(new Vektor(35, 30), function () { trace("hallo"); } ));
			buttons.push(play);
			buttons.push(pause);
			buttons.push(mute);
			buttons.push(highscore);
			buttons.join;
		}
		
		
		private function initButtons() {
			play = new Button(new Vektor(60, 30), function () { trace("play"); } );
			pause = new Button(new Vektor(35, 50), function() { trace("pause"); } );
			mute = new Button(new Vektor(85, 30), function() { trace("mute"); } );
			highscore = new Button(new Vektor(50, 50), function() { trace("highscore"); } );
		}
		
		public function join(a:Button, b:Button):Joint {
			var joint:Joint  = new Joint(a, b);
			a.addJoint(joint);
			b.addJoint(joint);
			joints.push(joint);
			return joint;
		}

	}
	
}