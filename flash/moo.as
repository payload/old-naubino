package {
	import flash.display.*;
	import flash.text.*;

	public class moo extends Sprite {
		public function moo() {
			var cls:Class = Sprite;
			var a:Sprite = new cls();
			a.graphics.beginFill(0xFF0000);
			a.graphics.drawCircle(20, 20, 10);
			a.graphics.endFill();
			addChild(a);

			var b:TextField = new TextField();
			b.text = "moo";
			b.x = 10;
			b.y = 10;
			b.width = 100;
			b.height = 30;
			a.addChild(b);
		}
	}
}