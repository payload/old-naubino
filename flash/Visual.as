package {

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.text.*;

	import stat.es.*;

	import caurina.transitions.Tweener;

	public class Visual {

		public var game : Game;
		private var root : Naubino;
		private var sprites : Dictionary;
		private var usedSprites : Dictionary;
		private var layers : Object = {};
		public var overlays:Sprite = new Sprite();
		private var overlayed:Boolean = false;

		private var lineColor : Color;
		private var backgroundColor : Color;

		public var highscore:VisualHighscore;
		public var lost:VisualLost;

		public function Visual(root:Naubino) {
			this.root = root;
			game = root.game;
			lineColor = Color.black;
			backgroundColor = Color.white;
			sprites = new Dictionary();
			initLayers();
			root.addEventListener(Event.ENTER_FRAME, function(e:Event):void{ update(); });
			initFog();
			highscore = new VisualHighscore(this);
			lost = new VisualLost(this);
			drawBackground();
			drawMenu();
		}
		
				
		private function update():void {
			usedSprites = new Dictionary();
			updateSprites();
			updateField();
			removeUnusedSprites();

		/*	if(!overlayed && game.lost)
				overlayLost();		*/
		}
		
		private function drawMenu():void {
			layers.menu0.graphics.beginFill(0, 0);
			layers.menu0.graphics.drawCircle(game.menu.mainbtn.x, game.menu.mainbtn.y, 65);
			layers.menu0.graphics.endFill();
		}

		private function drawBackground():void {
			root.graphics.beginFill(utils.colorToUInt(backgroundColor));
			root.graphics.drawRect(0, 0, game.width, game.height);
			root.graphics.endFill();
		}

		private function initLayers():void {
			layers.background	= new Sprite();
			layers.balls		= new Sprite();
			layers.joints		= new Sprite();
			layers.fog      = new Sprite();
			layers.menu0		= new Sprite(); // menu mouse over field (also menu joints, but we can't :-/)
			layers.menu1		= new Sprite(); // main menu button // XXX not a ordering I understand ??
			layers.menu2		= new Sprite(); // menu buttons
			layers.menu3    = new Sprite();
		 
			overlays		= new Sprite();
			
			root.addChild(layers.background);
			root.addChild(layers.joints);
			root.addChild(layers.balls);
			root.addChild(layers.fog);
			root.addChild(overlays);
			root.addChild(layers.menu0);
			layers.menu0.addChild(layers.menu1);
			layers.menu1.addChild(layers.menu2);
			layers.menu2.addChild(layers.menu3);

	
			
			layers.menu0.addEventListener(
				MouseEvent.MOUSE_OVER,
				function(e:*):void { game.menu.popUp() } );
			layers.menu0.addEventListener(
				MouseEvent.MOUSE_OUT, 
				function(e:*):void { game.menu.popDown() });
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
		
		private function updateSprites():void {
			var objs:Array = game.objs;
			for (var i:* in objs) {
				var obj:* = objs[i];
				updateSprite(obj);
			}
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
			var layer:* = layers.menu1;
			var bs:Sprite = getSprite(b, layer);
			bs.graphics.clear();
			//bs.graphics.lineStyle(2, utils.colorToUInt(Color.black));
			bs.graphics.lineStyle();
			bs.graphics.beginFill(utils.colorToUInt(b.color));
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
			points.mouseEnabled = false;
			layer.addChild(points); 

			if(game.points < 10){
				format.size = 36;
				points.x = bs.x-15;
				points.y = bs.y-25;
			}
			else if(game.points < 100){
				format.size = 26;
				format.letterSpacing = -3.0;
				points.x = bs.x-21;
				points.y = bs.y-19;
			}
			else{
				format.size = 22;
				format.letterSpacing = -3.0;
				points.x = bs.x-21;
				points.y = bs.y-16;
			}
			points.text = game.points.toString();
			points.setTextFormat(format);	
		}

		private function updateSecondaryButton(b:Button):void {
			var layer:* = layers.menu2;
			var bs:Sprite = getSprite(b, layer);
			bs.graphics.clear();
			//bs.graphics.lineStyle(2, utils.colorToUInt(Color.black));
			bs.graphics.lineStyle();
			bs.graphics.beginFill(utils.colorToUInt(b.color));
			bs.graphics.drawCircle(0, 0, b.visibleRadius);
			bs.graphics.endFill();
			
			if (b === game.menu.playbtn)
				bs = Icons.play(b, bs);

			switch (b.type){
				case "unmute":
					bs = Icons.unMute(b,bs);
				break;

				case "mute":
					bs = Icons.mute(b,bs);
				break;
				case "exit":	
					bs = Icons.exit(b,bs);
				break;
			}
			bs.graphics.endFill();
			

			bs.x = b.position.x;
			bs.y = b.position.y;
			bs.alpha = b.alpha;
		}
		
		public var fog:Sprite = new Sprite();
		public function initFog():void {
			var fog:Shape = new Shape();
			fog.graphics.beginFill(0xFFFFFF);
			fog.graphics.drawRect(0, 0, game.width, game.height);
			fog.graphics.endFill();
			fog.alpha = 0.6;
			hide(this.fog);
			this.fog.addChild(fog);
			layers.fog.addChild(this.fog);
		}

		public function hide(obj:DisplayObject, time:Number = 0):void {
			var tween:* = {
				alpha: 0,
				time: time,
				onComplete: function():void { obj.visible = false; }
			}
			Tweener.addTween(obj, tween);
		}
		public function show(obj:DisplayObject, time:Number = 0):void {
			var tween:* = {
				alpha: 1,
				time: time,
				onStart: function():void { obj.visible = true; }
			}
			Tweener.addTween(obj, tween);
		}

		public function drawOverlay(sprite:DisplayObject):void{
			show(fog, 3);
	
			overlays.addChild(sprite);

			overlayed = true;
		}
		
		public function clearOverlay():void{
			hide(fog, 3);

			overlays.parent.removeChild(overlays);
			overlays = new Sprite();
			root.addChild(overlays);
			overlayed = false;
		}
		private var foobar:int = 0;
		public function overlayNameField(inputName:TextField, btn:Button):void {
			var submitSprite:Sprite = new Sprite();
			var ok:TextField = new TextField();
						
			submitSprite.graphics.lineStyle();
			submitSprite.graphics.beginFill(utils.colorToUInt(btn.color));
			submitSprite.graphics.drawCircle(0, 0, btn.visibleRadius);
			submitSprite.graphics.endFill();
			submitSprite.x = btn.position.x;
			submitSprite.y = btn.position.y;
			submitSprite.alpha = btn.alpha;
			
			ok.text = "ok";
			ok.x = -8;
			ok.y = -8;
			foobar = foobar + 20;
			ok.textColor = 0000000;
			ok.mouseEnabled = false;

			submitSprite.addChild(ok);
			drawOverlay(submitSprite); // delete this line to find an easter egg
			drawOverlay(inputName);
		}

		/* drawing balls and field */
		
		private function updateField():void {
			var field:Sprite = getSprite("field", layers.background);
			field.graphics.clear();
			field.graphics.lineStyle(3,utils.colorToUInt(lineColor));
			field.graphics.drawCircle(0, 0, game.fieldSize);
			field.x = game.center.x;
			field.y = game.center.y;
		}
				
		private function updateBall(b:Ball):void {
			var bs:Sprite = getSprite(b, layers.balls);
			bs.graphics.clear();
			if (game.active == b) {
				bs.graphics.lineStyle(2, utils.colorToUInt(b.color));
			} else {
				bs.graphics.lineStyle();
			}
			bs.graphics.beginFill(utils.colorToUInt(b.color));
			bs.graphics.drawCircle(0, 0, b.visibleRadius);
			bs.graphics.endFill();
			bs.x = b.position.x;
			bs.y = b.position.y;
		}

		private function updateJoint(j:Joint):void {
			var layer:*;
			if (j.menu) layer = layers.menu3;
			else layer = layers.joints;

			var js:Sprite = getSprite(j, layer);
			js.graphics.clear();
			if (j.size > 0)
				js.graphics.lineStyle(j.size, utils.colorToUInt(lineColor));
			else
				js.graphics.lineStyle();
			js.graphics.moveTo(j.a.position.x, j.a.position.y);
			js.graphics.lineTo(j.b.position.x, j.b.position.y);
			js.alpha = j.alpha;
		}
	}
}
