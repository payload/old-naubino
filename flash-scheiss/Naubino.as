package 
{
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.text.Font;
	import flash.utils.Timer;
	import flash.utils.Dictionary;
	import flash.system.System;
	import flash.ui.Keyboard;
	
	public class Naubino extends Sprite
	{
		private var frameRate : int;
		private var game : Game;
		private var resolutionX : int;
		private var resolutionY : int;
		private var lineColor : Color;
		private var backgroundColor : Color;
		private var center : Vektor;
		private var enableDrawDirection : Boolean;
		private var enableDrawNumber : Boolean;
		private var myFont : Font; 
		private var refreshTimer: Timer;
		private var spamTimer: Timer;

		private var onKeyDown:Object = {};
		private var onKeyUp:Object = {};

		private function initKeys() {
			onKeyDown = {
			};
			onKeyUp = { 
				'ESC': close,
				'ENTER': function(){},
				'SPACE': game.restart,
				'CONTROL': function(){},
				'Q': function(){},
				'W': function(){}
			};		
		}
		
		private function initFields():void {
			frameRate = 40;
			game = new Game();
			initKeys();
			resolutionX = game.width;
			resolutionY = game.height;
			lineColor = Color.black;
			backgroundColor = Color.white;
			enableDrawDirection = false;
			enableDrawNumber = true;
			mouseChildren = false;
		}
		
		private function startTimer(delay:int, callback:Function):Timer {
			var timer:Timer = new Timer(delay);
			timer.addEventListener(TimerEvent.TIMER, function(e:Event):void { callback() } );
			timer.start();
			return timer;
		}

		public function Naubino() {
			initFields();
			addEventListener(Event.ENTER_FRAME, function(e:Event):void { draw() } );
			startTimer(50, game.refresh);
			startTimer(3500, game.spammer.randomPair);
			addEventListener(MouseEvent.MOUSE_DOWN, mousePressed);
			addEventListener(MouseEvent.MOUSE_UP, mouseReleased);
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoved);
			addEventListener(MouseEvent.ROLL_OUT, mouseReleased);
			addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}

		/* user control */

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

		private function close():void {
			System.exit(0);
		}

		private function nothing(down:Boolean):void {
		}

		public function keyDown(e:KeyboardEvent):void {
			for (var key:String in onKeyDown) {
				var keyCode = Keyboard[key];
				if (keyCode == e.keyCode)
					onKeyDown[key]();
			}
		}

		public function keyUp(e:KeyboardEvent):void {
			for (var key:String in onKeyUp) {
				var keyCode = Keyboard[key];
				if (keyCode == e.keyCode)
					onKeyUp[key]();
			}
		}

		/* drawing */

		private function clear():void {
			for (var i:uint = 0; i < numChildren; i++) {
				removeChildAt(i);
			}
		}
		
		private function draw():void {
			clear();
			drawField();
			drawJoints();
			drawBalls();
			drawMenu();
		}
				
		private function colorToUInt(color:Color):uint {
			return 0x010000 * color.r + 0x000100 * color.g + 0x000001 * color.b;
		}
		
		private function drawText():void {
	
		}

		private function drawField():void {
			var fs:Sprite = new Sprite();
			graphics.beginFill(colorToUInt(backgroundColor));
			graphics.drawRect(0, 0, game.width, game.height);
			graphics.endFill();
			fs.graphics.lineStyle(3,colorToUInt(lineColor));
			fs.graphics.drawCircle(game.center.x, game.center.y, game.fieldSize);
			//addChild(background);
		 	addChild(fs);
		}
		
		private function drawBalls():void {
			var balls:Array = game.balls;
			for (var i:uint = 0; i < balls.length; i++) {
				var ball:Ball = balls[i];
				drawBall(ball);
			}
		}

		private function drawBall(b:Ball):void {
			var bs:Sprite = new Sprite();
			
			if (game.active == b) {
				bs.graphics.lineStyle(2, colorToUInt(Color.black));
			} else {
				bs.graphics.lineStyle();
			}
			bs.graphics.beginFill(colorToUInt(b.color));
			bs.graphics.drawCircle(b.position.x, b.position.y, b.visibleRadius);
			bs.graphics.endFill();
			addChild(bs);
		}

		private function drawJoints():void {
			var joints:Array = game.joints;
			for (var i:uint = 0; i < joints.length; i++) {
				var joint:Joint = joints[i];
				drawJoint(joint);
			}
		}

		private function drawJoint(j:Joint):void {
			var js:Sprite = new Sprite();
			js.graphics.lineStyle(2, colorToUInt(lineColor));
			js.graphics.moveTo(j.a.position.x, j.a.position.y);
			js.graphics.lineTo(j.b.position.x, j.b.position.y);
			addChild(js);
		}
		
		private function drawMenu():void {
			var menu:Menu = game.menu;
			var i:uint;
			for (i = 0; i < menu.joints.length; i++)
				drawJoint(menu.joints[i]);
			for (i = 0; i < menu.buttons.length; i++)
				drawBall(menu.buttons[i]);
		}
	}
}