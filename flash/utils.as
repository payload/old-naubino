package {
	import flash.utils.Timer;
	import flash.events.*;

		public class utils {
			public static function addAll(dest:Array, src:Array):void {
				for (var i:uint = 0; i < src.length; i++)
				dest.push(src[i]);
			}

			public static function startTimer(delay:int, callback:Function):Timer {
				var timer:Timer = newTimer(delay, callback);
				timer.start();
	  		return timer;
  		}

			public static function newTimer(delay:int, callback:Function):Timer {
				var timer:Timer = new Timer(delay);
				timer.addEventListener(TimerEvent.TIMER, function(e:*):void { callback() } );
				return timer;
			}
		}
}