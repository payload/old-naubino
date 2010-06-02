package 
{
	public class Menu
	{
		public var game:Game;
		public var objs:Array;
		public var mainbtn:Button;
		public var playbtn:Button;
		
		public function Menu(game : Game) {
			this.game = game;
			objs = game.objs;
			initButtons();
		}

		private function tracer(str:String):Function {
			return function():void { trace(str); };
		}
		
		private function newMainButton():Button {
			var btn : Button = new Button();
			btn.color = Color.yellow;
			btn.setAction(tracer("main"));
			objs.push(btn);
			return btn;
		}

		private function newPlayButton():Button {
			var btn : Button = new Button();
			btn.color = Color.blue;
			btn.setAction(tracer("play"));
			objs.push(btn);
			return btn;
		}
		
		private function initButtons():void {
			mainbtn = newMainButton();
			playbtn = newPlayButton();

			mainbtn.position = new Vektor(35, 30);
			playbtn.position = mainbtn.position.add(new Vektor(30, 5));

			join(mainbtn, playbtn);
		}
		
		public function join(a:Button, b:Button):Joint {
			var joint:Joint  = new Joint(a, b);
			a.addJoint(joint);
			b.addJoint(joint);
			objs.push(joint);
			return joint;
		}

	}
	
}