package {

	import flash.display.*;
	import flash.utils.*;
	import flash.events.Event;
	import flash.text.*;


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
			layers.background  = new Sprite();
			layers.foreground  = new Sprite();
			layers.foreground1 = new Sprite();
			layers.balls       = new Sprite();
			layers.joints      = new Sprite();
			root.addChild(layers.background);
			root.addChild(layers.joints);
			root.addChild(layers.balls);
			root.addChild(layers.foreground);
			root.addChild(layers.foreground1);
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

		private function getSprite(link:*, layer:DisplayObjectContainer, cls:Class = null):* {
			if(cls == null)
				cls = Sprite;			
			var sprite : DisplayObject = getExistingSprite(link);
			if (sprite == null)
				sprite = newSprite(link, layer, cls);
			return sprite;
		}

		private function newSprite(link:*, layer:DisplayObjectContainer, cls:Class):DisplayObject {
			var sprite : DisplayObject = new cls();
			sprites[link] = sprite;
			usedSprites[link] = sprite;
			layer.addChild(sprite);
			return sprite;
		}

		private function getExistingSprite(link:*):DisplayObject {
			var newSprite : Boolean = false;
			var sprite : DisplayObject = sprites[link];
			if (sprite == null)
				return null;
			usedSprites[link] = sprite;
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

		private function updateSprites():void {
			var objs:Array = game.objs;
			for (var i:* in objs) {
				var obj:* = objs[i];
				updateSprite(obj);
			}
		}

		private function updateSprite(obj:*):void {
			if (obj is Button) updateButton(obj);
			if (obj is Ball) updateBall(obj);
			//if (obj is Naub);
			if (obj is Joint) updateJoint(obj);
		}

		private function updateButton(b:Button):void {
			if (b === game.menu.mainbtn)
				updateMainButton(b);
			else
				updateSecondaryButton(b);
		}

		private function updateMainButton(b:Button):void {
			var layer:* = layers.foreground1;
			var bs:Sprite = getSprite(b, layer);
			bs.graphics.clear();
			//bs.graphics.lineStyle(2, colorToUInt(Color.black));
			bs.graphics.lineStyle();
			bs.graphics.beginFill(colorToUInt(b.color));
			//bs.graphics.drawCircle(0, 0, b.visibleRadius);
			var r:Number = b.visibleRadius;
			bs.graphics.drawRect(-r, -r, r*2, r*2);
			bs.graphics.endFill();

			bs.x = b.position.x;
			bs.y = b.position.y;
			bs.rotation = 10;
			bs.alpha = b.alpha;

			var points:TextField = getSprite("Points", layer, TextField);			
			var format:TextFormat = new TextFormat();
			format.bold = true;
			format.font = "Verdana";
			points.textColor = 0xffffff;
			layer.addChild(points); 

			if(game.points < 10){
				format.size = 36;
				points.x = bs.x-15;
				points.y = bs.y-25;
			}
			else if(game.points < 100){
				format.size = 26;
				points.x = bs.x-21;
				points.y = bs.y-19;
			}
			else{
				format.size = 20;
				format.letterSpacing = -3.0;
				points.x = bs.x-21;
				points.y = bs.y-16;
			}
			points.text = game.points.toString();
			points.setTextFormat(format);	

		}

		private function updateSecondaryButton(b:Button):void {
			var layer:* = layers.foreground;
			var bs:Sprite = getSprite(b, layer);
			bs.graphics.clear();
			//bs.graphics.lineStyle(2, colorToUInt(Color.black));
			bs.graphics.lineStyle();
			bs.graphics.beginFill(colorToUInt(b.color));
			bs.graphics.drawCircle(0, 0, b.visibleRadius);
			bs.graphics.endFill();
			
			var fillcolor:uint = colorToUInt(Color.white)

			bs.graphics.beginFill(fillcolor);
		switch (b.type){

		case "pause":
			bs.graphics.drawRect(-b.visibleRadius*0.4, -b.visibleRadius*0.4, b.visibleRadius*0.3, b.visibleRadius*0.8);
			bs.graphics.drawRect( b.visibleRadius*0.4, -b.visibleRadius*0.4,-b.visibleRadius*0.3, b.visibleRadius*0.8);
		break;
			
		case "play":
			bs.graphics.moveTo(-b.visibleRadius*0.35, -b.visibleRadius*0.4);
			bs.graphics.lineTo(-b.visibleRadius*0.35,  b.visibleRadius*0.4);
			bs.graphics.lineTo( b.visibleRadius*0.45,  0);
			bs.graphics.lineTo(-b.visibleRadius*0.35, -b.visibleRadius*0.4);
		break;

		case "muteoff":
			bs.graphics.drawRect(-b.visibleRadius*0.5,-b.visibleRadius*0.3,b.visibleRadius*0.3,b.visibleRadius*0.6);
			
			bs.graphics.moveTo( b.visibleRadius*0.3,  b.visibleRadius*0.5);
			bs.graphics.lineTo( b.visibleRadius*0.3, -b.visibleRadius*0.5);
			bs.graphics.lineTo(-b.visibleRadius*0.25, -b.visibleRadius*0.2);
			bs.graphics.lineTo(-b.visibleRadius*0.25,  b.visibleRadius*0.2);
			bs.graphics.lineTo( b.visibleRadius*0.3,  b.visibleRadius*0.5);
			bs.graphics.endFill();
		break;

		case "mute":
			bs.graphics.drawRect(-b.visibleRadius*0.6,-b.visibleRadius*0.3,b.visibleRadius*0.4,b.visibleRadius*0.6);
			
			bs.graphics.moveTo( b.visibleRadius*0.4,  b.visibleRadius*0.5);
			bs.graphics.lineTo( b.visibleRadius*0.4, -b.visibleRadius*0.5);
			bs.graphics.lineTo(-b.visibleRadius*0.35, -b.visibleRadius*0.2);
			bs.graphics.lineTo(-b.visibleRadius*0.35,  b.visibleRadius*0.2);
			bs.graphics.lineTo( b.visibleRadius*0.4,  b.visibleRadius*0.5);
			bs.graphics.endFill();

			bs.graphics.beginFill(fillcolor);			
			bs.graphics.moveTo( b.visibleRadius*0.4,  b.visibleRadius*0.6);
			bs.graphics.lineTo( b.visibleRadius*0.2,  b.visibleRadius*0.6);
			bs.graphics.lineTo(-b.visibleRadius*0.5, -b.visibleRadius*0.6);
			bs.graphics.lineTo(-b.visibleRadius*0.2, -b.visibleRadius*0.6);
			bs.graphics.lineTo( b.visibleRadius*0.4,  b.visibleRadius*0.6);
			bs.graphics.endFill();

			bs.graphics.beginFill(fillcolor);			
			bs.graphics.moveTo(-b.visibleRadius*0.5,  b.visibleRadius*0.6);
			bs.graphics.lineTo(-b.visibleRadius*0.2,  b.visibleRadius*0.6);
			bs.graphics.lineTo( b.visibleRadius*0.4, -b.visibleRadius*0.6);
			bs.graphics.lineTo( b.visibleRadius*0.2, -b.visibleRadius*0.6);
			bs.graphics.lineTo(-b.visibleRadius*0.5,  b.visibleRadius*0.6);
		break;
		case "exit":	
			bs.graphics.moveTo( b.visibleRadius*0.5,  b.visibleRadius*0.4);
			bs.graphics.lineTo( b.visibleRadius*0.2,  b.visibleRadius*0.4);
			bs.graphics.lineTo(-b.visibleRadius*0.5, -b.visibleRadius*0.4);
			bs.graphics.lineTo(-b.visibleRadius*0.2, -b.visibleRadius*0.4);
			bs.graphics.lineTo( b.visibleRadius*0.5,  b.visibleRadius*0.4);
			bs.graphics.endFill();

			bs.graphics.beginFill(fillcolor);			
			bs.graphics.moveTo(-b.visibleRadius*0.5,  b.visibleRadius*0.4);
			bs.graphics.lineTo(-b.visibleRadius*0.2,  b.visibleRadius*0.4);
			bs.graphics.lineTo( b.visibleRadius*0.5, -b.visibleRadius*0.4);
			bs.graphics.lineTo( b.visibleRadius*0.2, -b.visibleRadius*0.4);
			bs.graphics.lineTo(-b.visibleRadius*0.5,  b.visibleRadius*0.4);
		break;
			}
			bs.graphics.endFill();
			

			bs.x = b.position.x;
			bs.y = b.position.y;
			bs.alpha = b.alpha;
		}

		private function updateBall(b:Ball):void {
			var bs:Sprite = getSprite(b, layers.balls);
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

		private function updateJoint(j:Joint):void {
			var js:Sprite = getSprite(j, layers.joints);
			js.graphics.clear();
			if (j.size > 0)
				js.graphics.lineStyle(j.size, colorToUInt(lineColor));
			else
				js.graphics.lineStyle();
			js.graphics.moveTo(j.a.position.x, j.a.position.y);
			js.graphics.lineTo(j.b.position.x, j.b.position.y);
			js.alpha = j.alpha;
		}
	}
}
