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
		public var pause:VisualPause;
		public var help:VisualHelp;
		public var credits:VisualCredits;
		public var alertTimer:Timer;

		public function Visual(root:Naubino) {
			this.root = root;
			game = root.game;
			lineColor = Color.black;
			backgroundColor = Color.white;
			sprites = new Dictionary();
			initLayers();
			root.addEventListener(Event.ENTER_FRAME, function(e:Event):void{ update(); });
			initFog();
			help = new VisualHelp(this);
			highscore = new VisualHighscore(this);
			lost = new VisualLost(this);
			pause = new VisualPause(this);
			credits = new VisualCredits(this);
			drawBackground();
			drawMenu();
			initAlert();
			initPointsUpdateTimer();
		}
		

		private var old_c:int = 0;
		private function update():void {
			usedSprites = new Dictionary();
			updateSprites();
			updateField();
			removeUnusedSprites();

			// sprites:Dictionary has no length, size or count
			var c:int = 0;
			for (var i:* in sprites) c++;
			if (old_c != c) {
				//trace(c +" sprites");
				old_c = c;
			}

		/*	if(!overlayed && game.lost)
				overlayLost();		*/
		}
		
		private function drawMenu():void {
			layers.menu0.graphics.beginFill(0, 0);
			layers.menu0.graphics.drawCircle(game.menu.mainbtn.x, game.menu.mainbtn.y, 65);
			layers.menu0.graphics.endFill();
		}

		private function drawBackground():void {
			root.graphics.lineStyle(6, Color.random.toUInt());
			root.graphics.beginFill(backgroundColor.toUInt());
			trace("width & height: "+game.width+" "+game.height);
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
			layers.alert    = new Sprite();
		 
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
			root.addChild(layers.alert);

	
			
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
			if (obj is Ball) updateBall(obj);
			if (obj is Button) updateButton(obj);
			//if (obj is Naub);
			if (obj is Joint) updateJoint(obj);
		}

		private function updateButton(b:Button):void {
			if (b === game.menu.mainbtn)
				updateMainButton(b);
			else
				updateSecondaryButton(b);
		}

		private var game_points:int = 0;
		private var points_update_timer:Timer;
		private function initPointsUpdateTimer():void {
			points_update_timer = utils.startTimer(150, updateGamePoints);
		}
		private function updateGamePoints():void {
			if (game_points < game.points) game_points++;
			if (game_points > game.points) game_points--;
		}

		private function updateMainButton(b:Button):void {
			var layer:* = layers.menu1;
			var bs:Sprite = getSprite(b, layer);
			bs.graphics.clear();
			//bs.graphics.lineStyle(2, Color.black.toUInt());
			bs.graphics.lineStyle();
			bs.graphics.beginFill(b.color.toUInt());
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

			points.text = game_points.toString();
			if (points.text.length < 2) {
				format.size = 36;
				points.x = bs.x-15;
				points.y = bs.y-25;
			}
			else if (points.text.length < 3) {
				format.size = 26;
				format.letterSpacing = -3.0;
				points.x = bs.x-21;
				points.y = bs.y-19;
			}
			else {
				format.size = 22;
				format.letterSpacing = -3.0;
				points.x = bs.x-21;
				points.y = bs.y-16;
			}
			points.text = game_points.toString();
			points.setTextFormat(format);	
		}

		private function updateSecondaryButton(b:Button):void {
			var layer:* = layers.menu2;
			var bs:Sprite = getSprite(b, layer);
			bs.graphics.clear();
			//bs.graphics.lineStyle(2, Color.black.toUInt());
			bs.graphics.lineStyle();
			bs.graphics.beginFill(b.color.toUInt());
			bs.graphics.drawCircle(0, 0, b.visibleRadius);
			bs.graphics.endFill();
			
			if (b === game.menu.playbtn)
				bs = Icons.play(b, bs);

			switch (b.type){
				case "unmute":
					bs = Icons.unMute(b, bs);
				break;
				case "mute":
					bs = Icons.mute(b, bs);
				break;
				case "reset":	
					bs = Icons.exit(b, bs);
				break;
				case "exit":	
					bs = Icons.exit(b, bs);
				break;
				case "help":
					bs = Icons.help(b, bs);
					break;
			}
			

			bs.x = b.position.x;
			bs.y = b.position.y;
			bs.alpha = b.alpha;
		}
		
		public var fog:Sprite = new Sprite();
		public function initFog():void {
			hide(this.fog);
			layers.fog.addChild(this.fog);
			var oversize:int = 40;

			var fog:Shape = new Shape();
			fog.graphics.beginFill(0xFFFFFF);
			fog.graphics.drawRect(-oversize, -oversize, game.width+oversize, game.height+oversize);
			fog.graphics.endFill();
			fog.alpha = 0.8;
			this.fog.addChild(fog);

			var x:Shape = new Shape();
			x.graphics.beginFill(0x0000FF);
			x.graphics.drawCircle(200, 200, 100);
			x.graphics.endFill();
			x.alpha = 0.8;
			//			this.fog.addChild(x);
		}
		
		public var alert:Sprite = new Sprite();
		private var glareOn:Boolean = false;
		private var defaultAlertDelay: int  = 1000;
		public function initAlert():void  {
			hide(this.alert);
			alertTimer = utils.startTimer(defaultAlertDelay, showAlert);
			alertTimer.stop();
		}

		public function showAlert():void {
			const fastestFlickering:Number = 300;
			var wishedAlertDelay:Number = defaultAlertDelay - ( defaultAlertDelay - fastestFlickering )
				*Math.pow(game.antipoints / game.ballsTillLost, 4);
			
			if(wishedAlertDelay < alertTimer.delay)
				alertTimer.delay -= 15;

			else if(wishedAlertDelay > alertTimer.delay)
				alertTimer.delay += 15;

			var tweenTime:Number = alertTimer.delay / 2000;
			var self:Visual = this;
			var shrink:* = {
				fieldLine : 3,
				time : tweenTime,
				delay : tweenTime
			}
			var grow:* = {	
				fieldLine: 10,
				time: tweenTime
			}
			var lightUp:* = {
				r : Color.red.r,
				g : Color.red.g,
				b : Color.red.b,
				time : tweenTime
			}
			var lightDown:* = {
				r : Color.grey.r,
				g : Color.grey.g,
				b : Color.grey.b,
				time : tweenTime,
				delay : tweenTime
			}
			Tweener.addTween(self, grow);
			Tweener.addTween(self, shrink);
			Tweener.addTween(fieldColor, lightUp);
			Tweener.addTween(fieldColor, lightDown);
		}

		public function startAlert():void{
			if(!alertTimer.running){
				alertTimer.start();
			}
			//alertTimer.delay = interval;
		}
		public function stopAlert():void{
			fieldLine = defaultFieldLine;
			alertTimer.stop();
			trace("stopTimer");
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

//		public function drawOverlay(sprite:DisplayObject):void{
//			show(fog, 3);
//			overlays.addChild(sprite);
//			overlayed = true;
//		}
		
		/* drawing balls and field */
		private var defaultFieldLine:Number = 3
		public var fieldLine:Number = defaultFieldLine;
		public var fieldColor:Color = Color.grey;
		private function updateField():void {
			var field:Sprite = getSprite("field", layers.background);
			if(fieldColor ==null)
				fieldColor = Color.grey;
			field.graphics.clear();
			field.graphics.lineStyle(fieldLine, fieldColor.toUInt());
			field.graphics.drawCircle(0, 0, game.fieldSize);
			field.x = game.center.x;
			field.y = game.center.y;
		}
				
		private function updateBall(b:Ball):void {
			var bs:Sprite = getSprite(b, layers.balls);
			bs.graphics.clear();
			if (game.active == b) {
				bs.graphics.lineStyle(2, b.color.toUInt());
			} else {
				bs.graphics.lineStyle();
			}
			bs.graphics.beginFill(b.color.toUInt());
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
				js.graphics.lineStyle(j.size, lineColor.toUInt());
			else
				js.graphics.lineStyle();
			js.graphics.moveTo(j.a.position.x, j.a.position.y);
			js.graphics.lineTo(j.b.position.x, j.b.position.y);
			js.alpha = j.alpha;
		}
	}
}
