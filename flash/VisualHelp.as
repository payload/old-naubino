package {
	
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.text.*;

	public class VisualHelp extends VisualModule {
		
		public var help1:Sprite = new Sprite();
		public var helptext1:TextField;
		
		public function VisualHelp(visual:Visual) {
			super(visual);
			visual.overlays.addChild(help1);
			visual.hide(help1);
			initStartText();
		}

		public function show():void {
			visual.show(help1, 2);
		}

		public function hide():void {
			visual.hide(help1, 2);
		}
		
		private function initStartText(): void {
			var format:TextFormat;
			format = new TextFormat();
			format.size = 16;
			format.bold = true;
			format.font = "Verdana";
			format.align = TextFormatAlign.LEFT;

			helptext1 = new TextField();
			helptext1.width = game.width/3;
			helptext1.height = game.height/2;
			helptext1.wordWrap = true;
			helptext1.mouseEnabled = false;
			helptext1.textColor = utils.colorToUInt(Color.black);
			helptext1.x = 10;
			helptext1.y = game.height - game.height/2;
			helptext1.text = "Willkommen bei Naubino!\n" + 
			"Die bunten Kugeln (Naubs) fliegen zur Mitte des Spielfeldes." + 
			"Versuche, einen Naub mit Hilfe der Maus zu verschieben.";
			helptext1.setTextFormat(format);
			help1.addChild(helptext1);
		}
		
		
	}
}
