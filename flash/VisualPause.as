package {

	import flash.display.*;
	import flash.text.*;

	public class VisualPause extends VisualModule {

		public var pause:Sprite;
		private var message:TextField;
		private var input:TextField;
		private var format:TextFormat;

		public function VisualPause(visual:Visual) {
			super(visual);

			pause = new Sprite();
			visual.overlays.addChild(pause);
			visual.hide(pause);
			
			initMessage();
		}

		public function show():void {
			visual.show(visual.fog, 2);
			visual.show(pause, 2);
		}

		public function hide():void {
			visual.hide(visual.fog, 2);
			visual.hide(pause, 2);
		}

		private function initMessage():void {
			var text:String = "Naubs Paused";
			var format:TextFormat = new TextFormat();
			message = new TextField();
						
			format.bold = true;
			format.font = "Verdana";
			format.size = 45;
			format.align = TextFormatAlign.CENTER ;
			
			message.mouseEnabled = false;
			message.textColor = utils.colorToUInt(Color.red);
			message.text = text;
			message.setTextFormat(format);
			message.autoSize = TextFieldAutoSize.CENTER;
			message.x = game.center.x-message.width/2;
			message.y = game.center.y-message.height/2;

			pause.addChild(message);
		}
	}
}
