package{
	import flash.display.*;
	import flash.geom.*;
	
	public class GameObjectManager{
		
		private static var instance : GameObjectManager;
		private var objects : Array;
		private var width : int = 600;
		private var height : int = 400;
		public var backBuffer : BitmapData;

		public static function get Instance() : GameObjectManager {
			if (instance == null) { 
				instance = new GameObjectManager(); 
			}
			return instance;
		}
		
		public function GameObjectManager(){
			backBuffer = new BitmapData(width, height, false, 0xFF000000);
			objects = new Array();
		}
		
		public function startup() : void {
			addFlakes(5);
		}
		
		public function update() : void {
			backBuffer.fillRect(new Rectangle(0, 0, width, height), 0xFF000000);
			objects.forEach(updateObject);
			objects.forEach(drawObject);
		}

		private function addFlakes(n : int) {
			for (;n;n--) {
				addFlake();
			}
		}

		private function addFlake() : void {
			var rand = function() : Number { return Math.random(); };
			var x : Number = rand() * width;
			var y : Number = rand() * height;
			var color : int = rand() * 0xFFFFFFFF;
			var sx : Number = rand() * 10;
			var sy : Number = rand() * 10;
			var flake : Ball = new Ball(new Vektor(x, y), 20);
			objects.push(flake);
		}

		private function updateObject(object:*, index:int, arr:Array) : void {
			object.update(0.2);
		}
		
		private function drawObject(object:*, index:int, arr:Array): void{
			var matrix : Matrix = new Matrix();
			matrix.translate(object.x, object.y);
			backBuffer.draw(object, matrix);
		}
	}
}