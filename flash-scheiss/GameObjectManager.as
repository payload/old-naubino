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
			drawAllObjects();
		}

		private function addFlakes(n : int) {
			for (;n;n--) {
				addFlake();
			}
		}

		private function addFlake() : void {
			var flake : Flake = new Flake(Math.random() * width, Math.random() * height, Math.random() * 0xFFFFFFFF );
			objects.push(flake);
		}

		private function drawAllObjects() : void {
			objects.forEach(drawObject);
		}
		
		private function drawObject(object:*, index:int, arr:Array): void{
			var matrix : Matrix = new Matrix();
			matrix.translate(object.x, object.y);
			backBuffer.draw(object, matrix);
		}
	}
}