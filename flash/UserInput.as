package {
	
	import flash.events.*;
	import flash.system.System;
	import flash.ui.Keyboard;

	public class UserInput {

		public var game:Game;

		public var onKeyDown:Object = {};
		public var onKeyUp:Object = {};

		private function initKeys():void {
			onKeyDown = {
			};
			onKeyUp = { 
				'ESC': close,
				'ENTER': game.spammer.randomPair,
				'SPACE': game.restart,
				'CONTROL': nothing,
				'Q': nothing,
				'W': nothing
			};		
		}

		public function close():void {
			//System.exit(0);
		}

		public function nothing():void {
		}

		public function UserInput(root:Naubino) {
			this.game = root.game;
			initKeys();
			addEventListeners(root);
		}

		private function addEventListeners(root:Naubino):void {
			root.addEventListener(MouseEvent.MOUSE_DOWN, mousePressed);
			root.addEventListener(MouseEvent.MOUSE_UP, mouseReleased);
			root.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoved);
			root.addEventListener(MouseEvent.ROLL_OUT, mouseReleased);
			root.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			root.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}

		public function mousePressed(e:MouseEvent):void {
			var v:Vektor = new Vektor(e.stageX, e.stageY);
			game.pointer = v;

			if (!e.altKey)
				game.pointerPressedLeft(v); //left
			else
				game.pointerPressedRight(v);//other than left :P
			
		}

		public function mouseMoved(e:MouseEvent):void {
			game.pointerMoved(new Vektor(e.stageX, e.stageY));
		}

		public function mouseReleased(e:MouseEvent):void {
			var v:Vektor = new Vektor(e.stageX, e.stageY);
				game.pointerReleasedLeft(v);
		}

		public function keyDown(e:KeyboardEvent):void {
			for (var key:String in onKeyDown) {
				var keyCode:uint = Keyboard[key];
				if (keyCode == e.keyCode)
					onKeyDown[key]();
			}
		}

		public function keyUp(e:KeyboardEvent):void {
			for (var key:String in onKeyUp) {
				var keyCode:uint = Keyboard[key];
				if (keyCode == e.keyCode)
					onKeyUp[key]();
			}
		}
  }
}