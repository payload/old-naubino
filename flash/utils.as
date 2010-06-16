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

			public static function colorToUInt(color:Color):uint {
				return 0x010000 * color.r + 0x000100 * color.g + 0x000001 * color.b;
			}
		}

}
