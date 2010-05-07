package{
	import flash.display.*;
	import flash.geom.*;
	
	public class GameObjectManager{
		
		private static var instance : GameObjectManager;
		private var objects : Array;
		public var backBuffer : BitmapData;

		public static function get Instance() : GameObjectManager {
			if (instance == null) { 
				instance = new GameObjectManager(); 
			}
			return instance;
		}
		
		public function GameObjectManager(){
			backBuffer = new BitmapData(600, 400, false, 0xFF000000);
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
			var flake : Flake = new Flake();
			objects.push(flake);
		}

		private function drawAllObjects() : void {
			objects.forEach(drawObject);
		}
		
		private function drawObject(object:*, index:int, arr:Array): void{
			backBuffer.draw(object);
		}
	}
}