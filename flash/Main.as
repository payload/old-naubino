package {
	import flash.display.Sprite;
	import flash.events.*;

  [SWF(backgroundColor="#ffffff", frameRate="24", width="600", height="400")]
	public class Main extends Sprite {

		public var child:Sprite;

		public function Main() {
			trace("stage: "+stage.width+" "+stage.height);
			child = new Naubino();
			addChild(child);
			child.addEventListener(MouseEvent.CLICK, click);
		}

		public function click(e:MouseEvent):void {
//			stage.focus = child;
		}
	}
}
