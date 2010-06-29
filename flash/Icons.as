package {

	import flash.display.*;
	import flash.text.*;
	
	public class Icons{

		public static function play(b:Button, bs:Sprite):Sprite {
			var fillcolor:uint = Color.white.toUInt();
			if (b.type == "pause") {
				bs.graphics.beginFill(fillcolor);
				bs.graphics.drawRect(-b.visibleRadius*0.4, -b.visibleRadius*0.4, b.visibleRadius*0.3, b.visibleRadius*0.8);
				bs.graphics.drawRect( b.visibleRadius * 0.4, -b.visibleRadius * 0.4, -b.visibleRadius * 0.3, b.visibleRadius * 0.8);
				bs.graphics.endFill();
			} else
				if (b.type == "play") {
					bs.graphics.beginFill(fillcolor);
					bs.graphics.moveTo(-b.visibleRadius*0.35, -b.visibleRadius*0.4);
					bs.graphics.lineTo(-b.visibleRadius*0.35,  b.visibleRadius*0.4);
					bs.graphics.lineTo( b.visibleRadius*0.45,  0);
					bs.graphics.lineTo( -b.visibleRadius * 0.35, -b.visibleRadius * 0.4);
					bs.graphics.endFill();
				}
			return bs;
		}

		private static var ask:TextField;
		private static var ok:TextField;
		
		public static function initText(str:String):TextField {
				var format:TextFormat = new TextFormat();
				format.font = "Verdana";
				format.size = 15;
				format.bold = true;
				format.align = TextFormatAlign.CENTER;

				var field:TextField = new TextField();
				field.mouseEnabled = false;
				field.autoSize = TextFieldAutoSize.CENTER;
				field.textColor = 0xFFFFFF;
				field.text = str;
				field.setTextFormat(format);
				
				return field;
		}

		public static function help(b:Button, bs:Sprite):Sprite {
			if (ask == null) {
				ask = initText("¿");
			}
			if (!bs.contains(ask)) {
				bs.addChild(ask);
				ask.x = -7;
				ask.y = -12;
			}
			return bs;
		}
		
		public static function submit(b:Button, bs:Sprite):Sprite {
			if (ok == null) {
				ok = initText("ok");
			}
			if (!bs.contains(ok)) {
				bs.addChild(ok);
				ok.x = -13;
				ok.y = -13;
			}
			return bs;
		}

		public static function exit(b:Button, bs:Sprite):Sprite{
			var fillcolor:uint = Color.white.toUInt();
			bs.graphics.beginFill(fillcolor);
			bs.graphics.moveTo( b.visibleRadius*0.5,  b.visibleRadius*0.4);
			bs.graphics.lineTo( b.visibleRadius*0.2,  b.visibleRadius*0.4);
			bs.graphics.lineTo(-b.visibleRadius*0.5, -b.visibleRadius*0.4);
			bs.graphics.lineTo(-b.visibleRadius*0.2, -b.visibleRadius*0.4);
			bs.graphics.lineTo( b.visibleRadius*0.5,  b.visibleRadius*0.4);
			bs.graphics.endFill();

			bs.graphics.beginFill(fillcolor);			
			bs.graphics.moveTo(-b.visibleRadius*0.5,  b.visibleRadius*0.4);
			bs.graphics.lineTo(-b.visibleRadius*0.2,  b.visibleRadius*0.4);
			bs.graphics.lineTo( b.visibleRadius*0.5, -b.visibleRadius*0.4);
			bs.graphics.lineTo( b.visibleRadius*0.2, -b.visibleRadius*0.4);
			bs.graphics.lineTo(-b.visibleRadius*0.5,  b.visibleRadius*0.4);
			bs.graphics.endFill();
			return bs;
		}
	
		public static function unMute(b:Button, bs:Sprite):Sprite {
			var fillcolor:uint = Color.white.toUInt();
			bs.graphics.beginFill(fillcolor);
			bs.graphics.drawRect(-b.visibleRadius*0.5,-b.visibleRadius*0.3,b.visibleRadius*0.3,b.visibleRadius*0.6);
		
			bs.graphics.moveTo( b.visibleRadius*0.3,  b.visibleRadius*0.5);
			bs.graphics.lineTo( b.visibleRadius*0.3, -b.visibleRadius*0.5);
			bs.graphics.lineTo(-b.visibleRadius*0.25, -b.visibleRadius*0.2);
			bs.graphics.lineTo(-b.visibleRadius*0.25,  b.visibleRadius*0.2);
			bs.graphics.lineTo( b.visibleRadius*0.3,  b.visibleRadius*0.5);

			bs.graphics.endFill();
			return bs;
		}
	
		public static function mute(b:Button, bs:Sprite):Sprite {
			var fillcolor:uint = Color.white.toUInt();
			bs.graphics.beginFill(fillcolor);

			bs.graphics.drawRect(-b.visibleRadius*0.5,-b.visibleRadius*0.3,b.visibleRadius*0.3,b.visibleRadius*0.6);
			
			bs.graphics.moveTo( b.visibleRadius*0.3,  b.visibleRadius*0.5);
			bs.graphics.lineTo( b.visibleRadius*0.3, -b.visibleRadius*0.5);
			bs.graphics.lineTo(-b.visibleRadius*0.25, -b.visibleRadius*0.2);
			bs.graphics.lineTo(-b.visibleRadius*0.25,  b.visibleRadius*0.2);
			bs.graphics.lineTo( b.visibleRadius*0.3,  b.visibleRadius*0.5);
			bs.graphics.endFill();

			bs.graphics.beginFill(Color.red.toUInt());			
			bs.graphics.moveTo( b.visibleRadius*0.4,  b.visibleRadius*0.6);
			bs.graphics.lineTo( b.visibleRadius*0.2,  b.visibleRadius*0.6);
			bs.graphics.lineTo(-b.visibleRadius*0.5, -b.visibleRadius*0.6);
			bs.graphics.lineTo(-b.visibleRadius*0.2, -b.visibleRadius*0.6);
			bs.graphics.lineTo( b.visibleRadius*0.4,  b.visibleRadius*0.6);
			bs.graphics.endFill();

			bs.graphics.beginFill(Color.red.toUInt());			
			bs.graphics.moveTo(-b.visibleRadius*0.5,  b.visibleRadius*0.6);
			bs.graphics.lineTo(-b.visibleRadius*0.2,  b.visibleRadius*0.6);
			bs.graphics.lineTo( b.visibleRadius*0.4, -b.visibleRadius*0.6);
			bs.graphics.lineTo( b.visibleRadius*0.2, -b.visibleRadius*0.6);
			bs.graphics.lineTo(-b.visibleRadius*0.5,  b.visibleRadius*0.6);


			bs.graphics.endFill();
			return bs;
		}
	}
}
