package{
	import flash.display.Sprite;
	
	public class Flake extends Sprite {
		public var color : int;
		public function Flake(x:int, y:int, color:int) {
			this.x = x;
			this.y = y;
			this.color = color;
			graphics.beginFill(color);
			graphics.drawCircle(10, 10, 20);
			graphics.endFill();
			
		}
	}
}