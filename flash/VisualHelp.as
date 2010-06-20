package {
	
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.text.*;

	public class VisualHelp extends VisualModule {
		
		public var help:Sprite = new Sprite();
		public var helptext:TextField;
		private var helpformat:TextFormat;
		
		public function VisualHelp(visual:Visual) {
			super(visual);
			visual.overlays.addChild(help);
			visual.hide(help);
			initFormat();
			initText();
		}

		public function show():void {
			visual.show(help, 2);
		}

		public function hide():void {
			visual.hide(help, 2);
		}
		
		private function initFormat():void {
			var format:TextFormat;
			format = new TextFormat();
			format.size = 16;
			format.bold = true;
			format.font = "Verdana";
			format.align = TextFormatAlign.LEFT;
			helpformat = format;
		}
		
		private function initText(): void {
			helptext = new TextField();
			helptext.width = game.width/3;
			helptext.height = game.height/2;
			helptext.wordWrap = true;
			helptext.mouseEnabled = false;
			helptext.textColor = utils.colorToUInt(Color.black);
			helptext.x = 10;
			helptext.y = game.height - game.height/2;
			help.addChild(helptext);
		}
		
		public function setHelpText(text:String):void {
			helptext.text = text;
			helptext.setTextFormat(helpformat);
		}
	}
}
