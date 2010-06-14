package 
{
	import caurina.transitions.AuxFunctions;
	import caurina.transitions.Tweener;
	import stat.es.*;

	public class Menu
	{
		public var game:Game;
		public var naubino:Naubino; //argh
		public var objs:Array = [];
		public var folded:Boolean = true;
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

		public function popDown():void {
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
		
		public function popDownNow():void {
			for (var i:* in secondaryBtns) {
				var btn:Button = secondaryBtns[i];
				btn.collidable = false;
				btn.x = mainbtn.x;
				btn.y = mainbtn.y;
				btn.alpha = 0;
			}
			mainbtn.setAction(popUp);
		}

		public function popUp():void {
			var tween:Object;
			for (var i:* in secondaryBtns) {
				var btn:Button = secondaryBtns[i];
				tween = {};
				tween.alpha = 1;
				tween.x = btn.popUpX;
				tween.y = btn.popUpY;
				tween.time = 0.6;
				tween.onComplete = function():void { for (var i:* in secondaryBtns) secondaryBtns[i].collidable = true; };
				Tweener.addTween(btn, tween);
			}
			mainbtn.setAction(popDown);
		}

		private function newButton(color:Color, str:String, action:Function=null):Button {
			var btn : Button = new Button();
			btn.color = color;
			if(action == null)
				btn.setAction(tracer(str));
			else
				btn.setAction(action);	
			btn.type = str;
			objs.push(btn);
			return btn;
		}

		public function setPlayButton():void{
			if(game.state === game.paused){
				playbtn.setAction(playAction);
				playbtn.type = "play";
			}
			else if (game.state === game.playing){
				playbtn.setAction(pauseAction);
				playbtn.type = "pause";
			}
		}

		private function playAction():void{
			game.pause();
			//game.lost = false;
		}
		
		private function pauseAction():void{
			game.pause();
		}
		
		private function muteAction():void{
			mutebtn.setAction(unMuteAction);
			mutebtn.type = "unmute";
		}

		private function unMuteAction():void{
			mutebtn.setAction(muteAction);
			mutebtn.type = "mute";
		}

		private function exitAction():void{
			game.clear();
			game.state = game.paused;
			playbtn.setAction(playAction);
			playbtn.type = "play";
			game.points = 0;
		}
		
		private function initButtons():void {
			mainbtn = newMainButton();
			mainbtn.collidable = false;
			playbtn = newButton(Color.random, "pause",pauseAction);
			mutebtn = newButton(Color.random, "unmute",unMuteAction);
			//highbtn = newButton(Color.purple, "high");
			exitbtn = newButton(Color.random,"exit",exitAction);
			
			secondaryBtns.push(playbtn);
			secondaryBtns.push(mutebtn);
			//secondaryBtns.push(highbtn);
			secondaryBtns.push(exitbtn);

			const pi:Number = 3.14159;
			mainbtn.position = new Vektor(35, 30);
			var x:Number = -0.0;
			var step:Number = 0.24;
			playbtn.position = Vektor.polar(x * pi, 60); x += step;
			mutebtn.position = Vektor.polar(x * pi, 60); x += step;
			//highbtn.position = Vektor.polar(x * pi, 55); x += step;
			exitbtn.position = Vektor.polar(x * pi, 60);

			for (var i:* in secondaryBtns) {
				var btn:Button = secondaryBtns[i];
				btn.position = btn.position.mul(0.7).add(mainbtn.position);
				btn.popUpX = btn.x;
				btn.popUpY = btn.y;
				btn.visibleRadius = 12;
				join(mainbtn, btn);
			}
			
			popDownNow();
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
