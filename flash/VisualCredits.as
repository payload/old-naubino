package {

	import flash.display.*;
	import flash.text.*;

	public class VisualCredits extends VisualModule {

		public var credit:Sprite;
		private var message:TextField;
		private var head:TextField;
		private var format:TextFormat;

		public function VisualCredits(visual:Visual) {
			super(visual);

			credit = new Sprite();
			visual.overlays.addChild(credit);
			visual.hide(credit);
			
			initMessage();
		}

		public function show():void {
			visual.show(visual.fog, 2);
			visual.show(credit, 2);
		}

		public function hide():void {
			visual.hide(visual.fog, 2);
			visual.hide(credit, 2);
		}

		private function initMessage():void {
			var header:String = "Naubino\n"
			var text:String = "von Gilbert Röhrbein, Hendrik Sollich, " 
				+ "Alexandra Weiß.";
			var format:TextFormat = new TextFormat();
			var headformat:TextFormat = new TextFormat();
			message = new TextField();
			head = new TextField();

			headformat.bold = true;
			headformat.font = "Verdana";
			headformat.size = 35;
			headformat.align = TextFormatAlign.CENTER ;	
								
			format.bold = false;
			format.font = "Verdana";
			format.size = 18;
			format.align = TextFormatAlign.CENTER ;
			message.wordWrap = true;
			
			message.mouseEnabled = false;
			message.textColor = Color.random.toUInt();
			message.text = text;
			message.setTextFormat(format);
			message.autoSize = TextFieldAutoSize.CENTER;
			message.width = game.width/3;
			message.height = game.height/2;
			message.x = game.center.x-message.width/2;
			message.y = game.center.y-message.height/2;
			
			head.mouseEnabled = false;
			head.textColor = Color.random.toUInt();
			head.text = header;
			head.setTextFormat(headformat);
			head.autoSize = TextFieldAutoSize.CENTER;
			head.x = game.center.x-head.width/2;
			head.y = game.center.y-message.height;
			
			
			credit.addChild(head);
			credit.addChild(message);
		}
	}
}
