package 
{
	import caurina.transitions.Tweener;

	public class Menu
	{
		public var game:Game;
		public var naubino:Naubino; //argh
		public var objs:Array = [];
		public var mainbtn:Button;
		public var secondaryBtns:Array = [];
		public var playbtn:Button;
		public var mutebtn:Button;
		public var highbtn:Button;
		public var exitbtn:Button;
		
		public function Menu(game : Game) {
			this.game = game;
			naubino = game.naubino;
			initButtons();
			utils.addAll(game.objs, objs);
		}
		
		private function tracer(str:String):Function {
			return function():void { trace(str); };
		}
		
		private function newMainButton():Button {
			var btn : Button = new Button();
			btn.color = Color.yellow;
			btn.visibleRadius = 15;
			btn.setAction(popDown);
			objs.push(btn);
			return btn;
		}

		private function popDown():void {
			var tween:Object = {
				x: mainbtn.x,
				y: mainbtn.y,
				alpha: 0,
				time: 0.6
			};
			for (var i:* in secondaryBtns) {
				var btn:Button = secondaryBtns[i];
				btn.collidable = false;
				Tweener.addTween(btn, tween);
			}
			mainbtn.setAction(popUp);
		}

		private function popUp():void {
			var tween:Object;
			for (var i:* in secondaryBtns) {
				var btn:Button = secondaryBtns[i];
				tween = {};
				tween.alpha = 1;
				tween.x = btn.popUpX;
				tween.y = btn.popUpY;
				tween.time = 0.6;
				tween.onComplete = function():void { btn.collidable = true; };
				Tweener.addTween(btn, tween);
			}
			mainbtn.setAction(popDown);
		}

		private function newTestButton(color:Color, str:String):Button {
			var btn : Button = new Button();
			btn.color = color;
			btn.setAction(tracer(str));
			btn.type = str;
			objs.push(btn);
			return btn;
		}

		private function newPlayButton():Button {
			var btn : Button = new Button();
			btn.color = Color.random();
			btn.setAction(playAction);
			btn.type = "play";
			objs.push(btn);
			return btn;
		}

		private function playAction():void{
			game.unpause();
			playbtn.setAction(pauseAction);
			playbtn.type = "pause";
		}
		
		private function newPauseButton():Button {
			var btn : Button = new Button();
			btn.color = Color.random();
			btn.setAction(pauseAction);
			btn.type = "pause";
			objs.push(btn);
			return btn;
		}

		private function pauseAction():void{
			game.pause();
			playbtn.setAction(playAction);
			playbtn.type = "play";
		}

		private function newMuteButton():Button {
			return newTestButton(Color.blue, "mute");
		}

		private function newHighButton():Button {
			return newTestButton(Color.purple, "high");
		}

		private function newExitButton():Button {
			var btn : Button = new Button();
			btn.color = Color.random();
			btn.setAction(exitAction);
			btn.type = "exit";
			objs.push(btn);
			return btn;
		}

		private function exitAction():void{
			game.restart();
			game.pause(); // this needs mending
			playbtn.setAction(playAction);
			playbtn.type = "play";
		}
		
		private function initButtons():void {
			mainbtn = newMainButton();
			playbtn = newPauseButton();
			mutebtn = newMuteButton();
			highbtn = newHighButton();
			exitbtn = newExitButton();

			secondaryBtns.push(playbtn);
			secondaryBtns.push(mutebtn);
			secondaryBtns.push(highbtn);
			secondaryBtns.push(exitbtn);

			const pi:Number = 3.14159;
			mainbtn.position = new Vektor(35, 30);
			var x:Number = -0.1;
			var step:Number = 0.24;
			playbtn.position = Vektor.polar(x * pi, 70); x += step;
			mutebtn.position = Vektor.polar(x * pi, 60); x += step;
			highbtn.position = Vektor.polar(x * pi, 55); x += step;
			exitbtn.position = Vektor.polar(x * pi, 50);

			for (var i:* in secondaryBtns) {
				var btn:Button = secondaryBtns[i];
				btn.position = btn.position.mul(0.7).add(mainbtn.position);
				btn.popUpX = btn.x;
				btn.popUpY = btn.y;
				btn.visibleRadius = 12;
				join(mainbtn, btn);
			}
		}
		
		public function join(a:Button, b:Button):Joint {
			var joint:Joint  = new Joint(a, b);
			//joint.length = b.position.sub(a.position).length * 1.1;
			//joint.strength = Joint.defaultStrength;
			joint.strength = 0;
			objs.push(joint);
			return joint;
		}

	}
	
}
