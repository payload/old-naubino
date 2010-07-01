package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.media.*; 
	import flash.net.URLRequest; 

	
	public class Naubino extends Sprite
	{
		public var game : Game;
		private var userInput : UserInput;
		private var visual : Visual;
		public var sound : Sound;
		public var req:URLRequest;
		public var chan:SoundChannel;
		public var chanPosition:int;
		public var globalSound:Sound;

		private function initFields():void {
			game = new Game();
			game.naubino = this;
			mouseChildren = true;
			userInput = new UserInput(this);
			visual = new Visual(this);
			game.visual = visual;
			sound = new Sound();
			sound.addEventListener(Event.COMPLETE, onSoundLoaded); 
			req= new URLRequest("audio/track2.mp3");
			sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError); 

		}

		public function Naubino() {
			initFields();
			
			utils.startTimer(game.refreshInterval, game.refresh);
			sound.load(req); 
		}
		
		public function onSoundLoaded(event:Event):void { 
  		 	globalSound = event.target as Sound; 
		 	chan = globalSound.play(); 
		}
		
		public function onIOError(event:IOErrorEvent):void { 
			trace("The sound could not be loaded: " + event.text); 
		}
	}
}
