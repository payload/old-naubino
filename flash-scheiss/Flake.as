package{
	import flash.display.Sprite;
	
	public class Flake extends Sprite {
		public function Flake() {
			graphics.beginFill(0xFFFF0000);
			graphics.drawCircle(20, 20, 15);
			graphics.endFill();
		}
	}
}