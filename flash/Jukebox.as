package{
	import flash.events.*;
	import flash.media.*; 
	import flash.net.URLRequest; 

	public class Jukebox{
		private var sound:Sound;
		private var channel:SoundChannel = new SoundChannel();
		private var needle:int = 0;
		private var req:URLRequest;
		private var globalSound:Sound;
		private var transform:SoundTransform;
		private var failedToPlay:Boolean;
	
		public function Jukebox():void{
			failedToPlay = false;
			sound = new Sound();
			sound.addEventListener(Event.COMPLETE, onSoundLoaded); 
			req= new URLRequest("audio/track2.mp3");
			sound.load(req); 
			sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError); 
		}

		public function play():void{
			if(globalSound != null){
				channel = globalSound.play(needle);
				channel.addEventListener(Event.SOUND_COMPLETE, loop);
			}
			else
				failedToPlay = true;
			if(transform != null){
				channel.soundTransform = transform;
			}
			unMute();
		}

		private function loop(e:Event):void {
			if (channel != null) {
				channel.removeEventListener(Event.SOUND_COMPLETE, loop);
				play();
			}
		}

		public function pause():void{
			needle = channel.position;
			channel.stop();
		}
		
		public function stop():void{
			pause();
			needle = 0;
		}
		
		public function mute():void{
			transform = channel.soundTransform;
			transform.volume = 0;
			channel.soundTransform = transform;
		}
		
		public function unMute():void{
			transform = channel.soundTransform;
			transform.volume = 0.3;
			channel.soundTransform = transform;
		}

		public function onSoundLoaded(event:Event):void { 
			globalSound = event.target as Sound; 
			if(failedToPlay){
				channel = globalSound.play();
				transform = channel.soundTransform; 
			}
		}

		public function onIOError(event:IOErrorEvent):void { 
			trace("The sound could not be loaded: " + event.text); 
		}
	}
}
