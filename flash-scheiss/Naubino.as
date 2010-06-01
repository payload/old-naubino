package 
{
	import flash.display.*;
	import flash.events.*;
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
		private var refreshTimer : Timer;
		private var spamTimer : Timer;
		private var sprites : Dictionary;
		private var usedSprites : Dictionary;
		private var layers : Object = {
			background: new Sprite(),
			foreground: new Sprite(),
			balls: new Sprite(),
			joints: new Sprite()
		};

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
			sprites = new Dictionary();
			initLayers();
		}

		private function initLayers():void {
			for (var i:* in layers) {
				var layer:Sprite = layers[i];
				addChild(layer);
			}
		}
		
		private function startTimer(delay:int, callback:Function):Timer {
			var timer:Timer = new Timer(delay);
			timer.addEventListener(TimerEvent.TIMER, function(e:Event):void { callback() } );
			timer.start();
			return timer;
		}

		public function Naubino() {
			initFields();
			addEventListener(Event.ENTER_FRAME, function(e:Event):void { update() } );
			startTimer(50, game.refresh);
			startTimer(3500, game.spammer.randomPair);
			addEventListener(MouseEvent.MOUSE_DOWN, mousePressed);
			addEventListener(MouseEvent.MOUSE_UP, mouseReleased);
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoved);
			addEventListener(MouseEvent.ROLL_OUT, mouseReleased);
			addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			addEventListener(KeyboardEvent.KEY_UP, keyUp);

			graphics.beginFill(colorToUInt(backgroundColor));
			graphics.drawRect(0, 0, game.width, game.height);
			graphics.endFill();

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

		private function removeChildFromLayer(child:DisplayObject):void {
			child.parent.removeChild(child);
		}

		private function removeUnusedSprites():void {
			for (var link:* in sprites)
				if (usedSprites[link] == undefined) {
					removeChildFromLayer(sprites[link]);
					delete sprites[link];
				}
		}
		
		private function update():void {
			usedSprites = new Dictionary();
			updateField();
			updateJoints();
			updateBalls();
			updateMenu();
			removeUnusedSprites();
		}
				
		private function colorToUInt(color:Color):uint {
			return 0x010000 * color.r + 0x000100 * color.g + 0x000001 * color.b;
		}
		
		private function drawText():void {
	
		}

		private function updateField():void {
			var sprite : Sprite = getSprite("field");
			if (sprite == null) {
				sprite = newSprite("field", layers.background);
				drawField(sprite);
			}
			sprite.x = game.center.x;
			sprite.y = game.center.y;y
		}

		private function drawField(field:Sprite):void {
			field.graphics.clear();
			field.graphics.lineStyle(3,colorToUInt(lineColor));
			field.graphics.drawCircle(0, 0, game.fieldSize);
		}

		private function newSprite(link:*, layer:DisplayObjectContainer = null):Sprite {
			var sprite : Sprite = new Sprite();
			sprites[link] = sprite;
			usedSprites[link] = sprite;
			if (layer == null)
				addChild(sprite);
			else
				layer.addChild(sprite);
			return sprite;
		}

		private function getSprite(link:*):Sprite {
			var newSprite : Boolean = false;
			var sprite : Sprite = sprites[link];
			if (sprite == undefined)
				return null;
			usedSprites[link] = sprite;
			return sprite;
		}
		
		private function updateBalls():void {
			var balls:Array = game.balls;
			for (var i:uint = 0; i < balls.length; i++) {
				var ball:Ball = balls[i];
				updateBall(ball);
			}
		}

		private function updateBall(b:Ball):void {
			var sprite : Sprite = getSprite(b);
			if (sprite == null) {
				sprite = newSprite(b, layers.balls);
				drawBall(sprite, b);
		 	}
			sprite.x = b.position.x;
			sprite.y = b.position.y;
		}

		private function drawBall(bs:Sprite, b:Ball):void {
			bs.graphics.clear();
			if (game.active == b) {
				bs.graphics.lineStyle(2, colorToUInt(Color.black));
			} else {
				bs.graphics.lineStyle();
			}
			bs.graphics.beginFill(colorToUInt(b.color));
			bs.graphics.drawCircle(0, 0, b.visibleRadius);
			bs.graphics.endFill();
		}

		private function updateJoints():void {
			var joints:Array = game.joints;
			for (var i:uint = 0; i < joints.length; i++) {
				var joint:Joint = joints[i];
				updateJoint(joint);
			}
		}

		private function updateJoint(j:Joint):void {
			var sprite : Sprite = getSprite(j);
			if (sprite == null) {
				sprite = newSprite(j, layers.joints);
		 	}
			drawJoint(sprite, j);
		}

		private function drawJoint(js:Sprite, j:Joint):void {
			js.graphics.clear();
			js.graphics.lineStyle(2, colorToUInt(lineColor));
			js.graphics.moveTo(j.a.position.x, j.a.position.y);
			js.graphics.lineTo(j.b.position.x, j.b.position.y);
		}
		
		private function updateMenu():void {
			var menu:Menu = game.menu;
			var i:uint;
			for (i = 0; i < menu.joints.length; i++)
				updateJoint(menu.joints[i]);
			for (i = 0; i < menu.buttons.length; i++)
				updateBall(menu.buttons[i]);
		}
	}
}