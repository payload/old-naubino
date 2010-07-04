package {
	
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.text.*;
	import caurina.transitions.Tweener;

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
			format.size = 14;
			format.bold = true;
			format.font = "Verdana";
			format.align = TextFormatAlign.LEFT;
			helpformat = format;
		}
		
		private function initText(): void {
			helptext = new TextField();
			helptext.width = game.width/3;
			helptext.height = game.height/3;
			helptext.wordWrap = true;
			helptext.mouseEnabled = false;
			helptext.textColor = Color.black.toUInt();
			helptext.x = 10;
			helptext.y = game.height - game.height/3;
			help.addChild(helptext);
		}
		
		public function setHelpText(text:String):void {
			var tweenhide:* = {
				alpha: 0,
				time: 2,
				onComplete: function():void { 
				helptext.visible = false; 
				helptext.text = text;
				helptext.setTextFormat(helpformat); }
			}
			Tweener.addTween(helptext, tweenhide);
			
			var tweenshow:*={
				delay: 2,
				alpha: 1,
				time: 2,
				onStart: function():void {helptext.visible = true;}
			}
			Tweener.addTween(helptext, tweenshow);
		}
		
		public function setFirstHelpText(text:String):void {
		
			var tweenshow:*={
				alpha: 1,
				time: 1,
				onStart: function():void {
					helptext.text = text;
					helptext.setTextFormat(helpformat);
					helptext.visible = true;}
			}
			Tweener.addTween(helptext, tweenshow);
		}
	}
}
