package 
{
	import caurina.transitions.Tweener;

	public class Menu
	{
		public var game:Game;
		public var objs:Array = [];
		public var mainbtn:Button;
		public var secondaryBtns:Array = [];
		public var playbtn:Button;
		public var mutebtn:Button;
		public var highbtn:Button;
		public var exitbtn:Button;
		
		public function Menu(game : Game) {
			this.game = game;
			initButtons();
			utils.addAll(game.objs, objs);
		}

		private function tracer(str:String):Function {
			return function():void { trace(str); };
		}
		
		private function newMainButton():Button {
			var btn : Button = new Button();
			btn.color = Color.yellow;
			btn.setAction(popDown);
			objs.push(btn);
			return btn;
		}

		private function popDown():void {
			var tween:Object = {
				x: mainbtn.x,
				y: mainbtn.y,
				time: 0.6
			};
			for (var i:* in secondaryBtns) {
				var btn:Button = secondaryBtns[i];
				btn.popUpX = btn.x;
				btn.popUpY = btn.y;
				Tweener.addTween(btn, tween);
			}
			mainbtn.setAction(popUp);
		}

		private function popUp():void {
			var tween:Object = {
				time: 0.6
			};
			for (var i:* in secondaryBtns) {
				var btn:Button = secondaryBtns[i];
				tween.x = btn.popUpX;
				tween.y = btn.popUpY;
				Tweener.addTween(btn, tween);
			}
			mainbtn.setAction(popDown);
		}

		private function newTestButton(color:Color, str:String):Button {
			var btn : Button = new Button();
			btn.color = color;
			btn.setAction(tracer(str));
			objs.push(btn);
			return btn;
		}

		private function newPlayButton():Button {
			return newTestButton(Color.blue, "play");
		}

		private function newMuteButton():Button {
			return newTestButton(Color.blue, "mute");
		}

		private function newHighButton():Button {
			return newTestButton(Color.blue, "high");
		}

		private function newExitButton():Button {
			return newTestButton(Color.blue, "exit");
		}
		
		private function initButtons():void {
			mainbtn = newMainButton();
			playbtn = newPlayButton();
			mutebtn = newMuteButton();
			highbtn = newHighButton();
			exitbtn = newExitButton();

			secondaryBtns.push(playbtn);
			secondaryBtns.push(mutebtn);
			secondaryBtns.push(highbtn);
			secondaryBtns.push(exitbtn);

			const pi:Number = 3.14159;
			mainbtn.position = new Vektor(35, 30);
			playbtn.position = Vektor.polar(-0.05 * pi, 60);
			mutebtn.position = Vektor.polar(0.15 * pi, 55);
			highbtn.position = Vektor.polar(0.35 * pi, 52);
			exitbtn.position = Vektor.polar(0.58 * pi, 50);

			for (var i:* in secondaryBtns) {
				var btn:Button = secondaryBtns[i];
				btn.position = btn.position.add(mainbtn.position);
				join(mainbtn, btn);
			}
		}
		
		public function join(a:Button, b:Button):Joint {
			var joint:Joint  = new Joint(a, b);
			joint.strength = 0;
			objs.push(joint);
			return joint;
		}

	}
	
}