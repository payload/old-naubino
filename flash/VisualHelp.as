package {
	
	import flash.display.*;
	import flash.text.*;

	public class VisualHelp extends VisualModule {
		
		public var help:Sprite = new Sprite();
		public var helptext:TextField;
		
		public function VisualHelp(visual:Visual) {
			super(visual);
			visual.overlays.addChild(help);
			visual.hide(help);
			initStartText();
		}

		public function show():void {
			visual.show(help, 2);
		}

		public function hide():void {
			visual.hide(help, 2);
		}
		
		private function initStartText(): void {
			var format:TextFormat;
			format = new TextFormat();
			format.size = 16;
			format.bold = true;
			format.font = "Verdana";
			format.align = TextFormatAlign.LEFT;

			helptext = new TextField();
			helptext.width = game.width/2;
			helptext.wordWrap = true;
			helptext.mouseEnabled = false;
			helptext.textColor = utils.colorToUInt(Color.black);
			helptext.x = game.width/4;// - helptext.width/2;
			helptext.y = game.height - game.height/3;
			helptext.text = "Willkommen bei Naubino!\n" + 
			"Die bunten Kugeln (Naubs) fliegen zur Mitte des Spielfeldes.\n" + 
			"Versuche, einen Naub mit Hilfe der Maus zu verschieben.";
			helptext.setTextFormat(format);
			help.addChild(helptext);
		}
	}
}

/* fade effekte */
