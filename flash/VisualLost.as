package {

	import flash.display.*;
	import flash.text.*;

	public class VisualLost extends VisualModule {

		public var lost:Sprite;
		private var message:TextField;
		private var input:TextField;

		public function VisualLost(visual:Visual) {
			super(visual);

			lost = new Sprite();
			visual.overlays.addChild(lost);
			visual.hide(lost);
			
			initMessage();
			initForm();
		}

		public function show():void {
			visual.show(visual.fog, 2);
			visual.show(lost, 2);
		}

		public function hide():void {
			visual.hide(visual.fog, 2);
			visual.hide(lost, 2);
		}

		private function initForm():void{
			var format:TextFormat = new TextFormat();
			format.font = "Verdana";
			format.size = 20;
			format.align = TextFormatAlign.CENTER;

			input = new TextField();
			input.maxChars = 15;
			input.type = TextFieldType.INPUT;
			input.border = true;

			input.text = "Anony Mous";
			input.setTextFormat(format);
			input.autoSize = TextFieldAutoSize.CENTER;
			input.x = game.center.x - input.width/2;
			input.y = message.y + message.height;

			lost.addChild(input);
		}

		private function initMessage():void {
			var text:String = "Naub Overflow";
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

			lost.addChild(message);
		}
	}
}