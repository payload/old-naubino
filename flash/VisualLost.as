package {

	import flash.display.*;
	import flash.text.*;
	import flash.events.*;

	public class VisualLost extends VisualModule {

		public var lost:Sprite;
		private var message:TextField;
		private var input:TextField;
		public var submit:Sprite;
		private var format:TextFormat;

		public function VisualLost(visual:Visual) {
			super(visual);

			lost = new Sprite();
			visual.overlays.addChild(lost);
			visual.hide(lost);
			
			initMessage();
			initForm();
		}

		public function show():void {
			resetInput();
			visual.show(visual.fog, 2);
			visual.show(lost, 2);
		}

		public function hide():void {
			visual.hide(visual.fog, 2);
			visual.hide(lost, 2);
		}

		private function resetInput():void {
			input.text = "Anonym";
			input.setTextFormat(format);
		}

		private function initForm():void{
			format = new TextFormat();
			format.font = "Verdana";
			format.size = 20;
			format.align = TextFormatAlign.CENTER;

			input = new TextField();
			input.maxChars = 15;
			input.type = TextFieldType.INPUT;
			input.border = true;

			resetInput();
			input.autoSize = TextFieldAutoSize.CENTER;
			input.x = game.center.x - input.width/2;
			input.y = message.y + message.height;

			submit = new Sprite();
			submit.addEventListener(MouseEvent.CLICK, function():void { 
				visual.game.states.lost.enterHallOfFame(input.text);
				game.state.changeState(game.states.highscore);
			} );
			submit.x = input.x + input.width + 20;
			submit.y = input.y + input.height/2;
			drawButton(submit);

			lost.addChild(submit);
			lost.addChild(input);
		}
		
		private function drawButton(bs:Sprite):void{
			bs.graphics.clear();
			bs.graphics.lineStyle();
			bs.graphics.beginFill(Color.random.toUInt());
			bs.graphics.drawCircle(0, 0, 13);
			bs.graphics.endFill();
			Icons.submit(bs);
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
			message.textColor = Color.red.toUInt();
			message.text = text;
			message.setTextFormat(format);
			message.autoSize = TextFieldAutoSize.CENTER;
			message.x = game.center.x-message.width/2;
			message.y = game.center.y-message.height/2;

			lost.addChild(message);
		}
	}
}
