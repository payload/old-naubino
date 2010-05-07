package{
	import flash.display.*;
	import flash.geom.*;
	
	public class GameObjectManager{
		
		public var backBuffer : BitmapData;
		private static var instance : GameObjectManager;
		public static function get Instance() : GameObjectManager {
			if (instance == null) { 
				instance = new GameObjectManager(); 
			}
			return instance;
		}
		
		public function GameObjectManager(){
			backBuffer = new BitmapData(600, 400, false, 0xFF000000);
		}
		
		public function startup() : void {
			var flake : Flake = new Flake();
			backBuffer.draw(flake);
			
		}
	}
}