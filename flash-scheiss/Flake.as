package{
	import flash.display.Sprite;
	
	public class Flake extends Sprite {
		
		public var sx:Number;
		public var sy:Number;
		public var color : int;
		
		public function Flake(x:Number, y:Number, sx:Number, sy:Number, color:int) {
			this.x = x;
			this.y = y;
			this.sx = sx;
			this.sy = sy;
			this.color = color;
			draw();
		}
		
		private function draw() : void {
			graphics.beginFill(color);
			graphics.drawCircle(10, 10, 20);
			graphics.endFill();
		}
		
		public function update(dt : Number) : void {
			x += sx * dt;
			y += sy * dt;
		}
	}
}