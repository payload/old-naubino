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
			root.addEventListener(Event.ENTER_FRAME, function(e:Event):void{ update(); });
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
			updateSprites();
			updateField();
			removeUnusedSprites();
		}
				
		private function colorToUInt(color:Color):uint {
			return 0x010000 * color.r + 0x000100 * color.g + 0x000001 * color.b;
		}

		private function getSprite(link:*, layer:DisplayObjectContainer):Sprite {
			var sprite : Sprite = getExistingSprite(link);
			if (sprite == null)
				sprite = newSprite(link, layer);
			return sprite;
		}

		private function updateField():void {
			var field:Sprite = getSprite("field", layers.background);
			field.graphics.clear();
			field.graphics.lineStyle(3,colorToUInt(lineColor));
			field.graphics.drawCircle(0, 0, game.fieldSize);
			field.x = game.center.x;
			field.y = game.center.y;
		}

		private function newSprite(link:*, layer:DisplayObjectContainer):Sprite {
			var sprite : Sprite = new Sprite();
			sprites[link] = sprite;
			usedSprites[link] = sprite;
			layer.addChild(sprite);
			return sprite;
		}

		private function getExistingSprite(link:*):Sprite {
			var newSprite : Boolean = false;
			var sprite : Sprite = sprites[link];
			if (sprite == null)
				return null;
			usedSprites[link] = sprite;
			return sprite;
		}

		private function updateSprites():void {
			var objs:Array = game.objs;
			for (var i:* in objs) {
				var obj:* = objs[i];
				updateSprite(obj);
			}
		}

		private function updateSprite(obj:*):void {
			//if (obj is Button);
			if (obj is Ball) updateBall(getSprite(obj, layers.balls), obj);
			//if (obj is Naub);
			if (obj is Joint) updateJoint(getSprite(obj, layers.joints), obj);
		}
		
		private function updateBall(bs:Sprite, b:Ball):void {
			bs.graphics.clear();
			if (game.active == b) {
				bs.graphics.lineStyle(2, colorToUInt(Color.black));
			} else {
				bs.graphics.lineStyle();
			}
			bs.graphics.beginFill(colorToUInt(b.color));
			bs.graphics.drawCircle(0, 0, b.visibleRadius);
			bs.graphics.endFill();
			bs.x = b.position.x;
			bs.y = b.position.y;
		}

		private function updateJoint(js:Sprite, j:Joint):void {
			js.graphics.clear();
			js.graphics.lineStyle(4, colorToUInt(lineColor));
			js.graphics.moveTo(j.a.position.x, j.a.position.y);
			js.graphics.lineTo(j.b.position.x, j.b.position.y);
		}
		
		private function updateMenu():void {
			var menu:Menu = game.menu;
			var i:uint;
			for (i = 0; i < menu.joints.length; i++)
				updateSprite(menu.joints[i]);
			for (i = 0; i < menu.buttons.length; i++)
				updateSprite(menu.buttons[i]);
		}
	}
}