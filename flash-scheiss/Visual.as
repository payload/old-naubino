package {

	import flash.display.*;
	import flash.utils.*;
	import flash.events.Event;

	public class Visual {

		private var game : Game;
		private var root : Naubino;
		private var sprites : Dictionary;
		private var usedSprites : Dictionary;
		private var layers : Object = {};

		private var lineColor : Color;
		private var backgroundColor : Color;

		public function Visual(root:Naubino) {
			this.root = root;
			game = root.game;
			lineColor = Color.black;
			backgroundColor = Color.white;
			sprites = new Dictionary();
			initLayers();
			root.addEventListener(Event.ENTER_FRAME, function(e:Event){ update(); });
			drawBackground();
		}

		private function drawBackground():void {
			root.graphics.beginFill(colorToUInt(backgroundColor));
			root.graphics.drawRect(0, 0, game.width, game.height);
			root.graphics.endFill();
		}

		private function initLayers():void {
			layers.background = new Sprite(),
			layers.foreground = new Sprite(),
			layers.balls      = new Sprite(),
			layers.joints     = new Sprite()
			root.addChild(layers.background);
			root.addChild(layers.joints);
			root.addChild(layers.balls);
			root.addChild(layers.foreground);
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
		
		private function updateField():void {
			var sprite : Sprite = getSprite("field");
			if (sprite == null) {
				sprite = newSprite("field", layers.background);
				drawField(sprite);
			}
			sprite.x = game.center.x;
			sprite.y = game.center.y;
		}

		private function drawField(field:Sprite):void {
			field.graphics.clear();
			field.graphics.lineStyle(3,colorToUInt(lineColor));
			field.graphics.drawCircle(0, 0, game.fieldSize);
		}

		private function newSprite(link:*, layer:DisplayObjectContainer):Sprite {
			var sprite : Sprite = new Sprite();
			sprites[link] = sprite;
			usedSprites[link] = sprite;
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