package {
	import flash.display.*;
	import flash.events.*;

	public class Naubino extends Sprite {
		public function Naubino() {
			addEventListener(Event.ENTER_FRAME, this.enterFrame)
			GameObjectManager.Instance.startup();
		}
		
		public function enterFrame(event:Event) : void {
			GameObjectManager.Instance.update();
			
			graphics.clear();
			graphics.beginBitmapFill(
				GameObjectManager.Instance.backBuffer, 
				null, false, false);
			graphics.drawRect(0, 0, 600, 400);
			graphics.endFill();
		}
	}
}