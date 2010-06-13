package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class Naubino extends Sprite
	{
		public var game : Game;
		private var refreshTimer : Timer;
		private var spamTimer : Timer;
		private var userInput : UserInput;
		private var visual : Visual;

		private function initFields():void {
			game = new Game(this);
			mouseChildren = true;
			userInput = new UserInput(this);
			visual = new Visual(this);
		}

		private function startTimer(delay:int, callback:Function):Timer {
			var timer:Timer = new Timer(delay);
			timer.addEventListener(TimerEvent.TIMER, function(e:Event):void { callback() } );
			timer.start();
			return timer;
		}

		public function Naubino() {
			initFields();
	
			refreshTimer = startTimer(game.refreshInterval, game.refresh);
			setSpammer();
		}
		public function setSpammer():void{
			spamTimer = startTimer(game.spammerInterval, game.spam);
		}
	}
}
