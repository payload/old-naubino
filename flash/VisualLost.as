package {

	import flash.display.*;
	import flash.text.*;

	public class VisualLost extends VisualModule {

		public var lost:Sprite;

		public function VisualLost(visual:Visual) {
			super(visual);

			lost = new Sprite();
			visual.overlays.addChild(lost);
			visual.hide(lost);
			
			var text:String = "Naub Overflow";
			var message:TextField = new TextField();			
			var format:TextFormat = new TextFormat();
						
			format.bold = true;
			format.font = "Verdana";
			format.size = 45;
			format.align = TextFormatAlign.CENTER ;
			
			message.mouseEnabled = false;
			message.width = game.width;
			message.height = 100;
			message.textColor = utils.colorToUInt(Color.red);
			message.x = game.center.x-message.width/2;
			message.y = game.center.y-message.height/2;
			message.text = text;
			message.setTextFormat(format);

			lost.addChild(message);
		}

		public function show():void {
			visual.show(visual.fog, 2);
			visual.show(lost, 2);
		}

		public function hide():void {
			visual.hide(visual.fog, 2);
			visual.hide(lost, 2);
		}
	}
}