package {
	import flash.display.*;
	
	public class Icons{

	public static function play(b:Button, bs:Sprite):Sprite {
		var fillcolor:uint = utils.colorToUInt(Color.white);
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

	public static function exit(b:Button, bs:Sprite):Sprite{
		var fillcolor:uint = utils.colorToUInt(Color.white);
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
		var fillcolor:uint = utils.colorToUInt(Color.white);
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
		var fillcolor:uint = utils.colorToUInt(Color.white);
			bs.graphics.beginFill(fillcolor);

			bs.graphics.drawRect(-b.visibleRadius*0.6,-b.visibleRadius*0.3,b.visibleRadius*0.4,b.visibleRadius*0.6);
			
			bs.graphics.moveTo( b.visibleRadius*0.4,  b.visibleRadius*0.5);
			bs.graphics.lineTo( b.visibleRadius*0.4, -b.visibleRadius*0.5);
			bs.graphics.lineTo(-b.visibleRadius*0.35, -b.visibleRadius*0.2);
			bs.graphics.lineTo(-b.visibleRadius*0.35,  b.visibleRadius*0.2);
			bs.graphics.lineTo( b.visibleRadius*0.4,  b.visibleRadius*0.5);
			bs.graphics.endFill();

			bs.graphics.beginFill(utils.colorToUInt(Color.red));			
			bs.graphics.moveTo( b.visibleRadius*0.4,  b.visibleRadius*0.6);
			bs.graphics.lineTo( b.visibleRadius*0.2,  b.visibleRadius*0.6);
			bs.graphics.lineTo(-b.visibleRadius*0.5, -b.visibleRadius*0.6);
			bs.graphics.lineTo(-b.visibleRadius*0.2, -b.visibleRadius*0.6);
			bs.graphics.lineTo( b.visibleRadius*0.4,  b.visibleRadius*0.6);
			bs.graphics.endFill();

			bs.graphics.beginFill(utils.colorToUInt(Color.red));			
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
