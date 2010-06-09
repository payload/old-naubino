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
			mouseChildren = false;
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
	
			refreshTimer = startTimer(50, game.refresh);
			spamTimer = startTimer(2500, game.spammer.randomPair);
		}
		public function pause():void{
			spamTimer.stop();
			refreshTimer.stop();
		}
		public function unpause():void
		{
			spamTimer.start();
			refreshTimer.start();
		}
	}
}
