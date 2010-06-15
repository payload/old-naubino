package {
	import flash.display.Sprite;
	import flash.events.*;

	public class Main extends Sprite { // TODO Perhaps one day this might extend stage

		public var child:Sprite;

		public function Main() {
			child = new Naubino();
			addChild(child);
			child.addEventListener(MouseEvent.CLICK, click);
		}

		public function click(e:MouseEvent):void {
			//stage.focus = child; // XXX brakes highscore namefield focus
		}

	}
}
