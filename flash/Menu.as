package 
{
	public class Menu
	{
		public var buttons:Array = [];
		public var joints:Array = [];
		public var mainbtn:Button;
		
		public function Menu() {
			initButtons();
		}

		private function tracer(str:String):Function {
			return function():void { trace(str); };
		}
		
		private function newMainButton():Button {
			var btn : Button = new Button();
			btn.position = new Vektor(35, 30);
			btn.attractedTo = btn.position;
			btn.color = Color.yellow;
			btn.setAction(tracer("main"));
			buttons.push(btn);
			return btn;
		}
		
		private function initButtons():void {
			mainbtn = newMainButton();
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