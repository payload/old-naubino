package {

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.text.*;

	import stat.es.*;

	public class Visual {

		private var game : Game;
		private var root : Naubino;
		private var sprites : Dictionary;
		private var usedSprites : Dictionary;
		private var layers : Object = {};
		private var overlays:Sprite = new Sprite();
		private var overlayed:Boolean = false;

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
			drawMenu();
		}
		
				
		private function update():void {
			usedSprites = new Dictionary();
			updateSprites();
			updateField();
			removeUnusedSprites();

			if(!overlayed && game.lost)
				overlayLost();
			/*if(!overlayed && game.state is Highscore)
				overlayHighscore();*/
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
			layers.menu0		= new Sprite(); // menu mouse over field (also menu joints, but we can't :-/)
			layers.menu1		= new Sprite(); // main menu button // XXX not a ordering I understand ??
			layers.menu2		= new Sprite(); // menu buttons

			overlays		= new Sprite();
			
			root.addChild(layers.background);
			root.addChild(layers.joints);
			root.addChild(layers.balls);
			root.addChild(layers.menu0);
			layers.menu0.addChild(layers.menu1);
			layers.menu1.addChild(layers.menu2);

			root.addChild(overlays);
			
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
		

		public function overlayNameField(btn:Button):void {
			overlayed = true;
			overlays = new Sprite();
			root.addChild(overlays);
			var inputName:TextField = new TextField();
			var submitSprite:Sprite = new Sprite();
			var submit:Button = new Button();

			inputName.maxChars = 15;

			inputName.type = TextFieldType.INPUT;
			inputName.border = true;
			inputName.width = 150;
			inputName.height = 26;
			inputName.x = game.center.x-inputName.width/2;
			inputName.y = game.center.y-inputName.height;
			
			submit.setAction(function():void{trace("sent ok");});
			submit.color = Color.random;
			submit.x = game.center.x + inputName.width/2;
			submit.y = inputName.y;
			
			
			overlays.graphics.lineStyle();
			overlays.graphics.beginFill(utils.colorToUInt(submit.color));
			overlays.graphics.drawCircle(0, 0, submit.visibleRadius);
			overlays.graphics.endFill();
			overlays.x = submit.position.x;
			overlays.y = submit.position.y;
			overlays.alpha = submit.alpha;
			game.objs.push();

			overlays.addChild(inputName);

		}
		

		public function overlayList(list:Object):void {	
		
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0xFFFFFF);
			s.graphics.drawRect(0,0,game.width,game.height);
			s.graphics.endFill();
			s.alpha = 0.6;
			
			overlayed = true;
			overlays = new Sprite();
			root.addChild(overlays);				
			var text:String = "";
			var table:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			

			format.size = 20;
			format.bold = false;
			format.font = "Verdana";
			format.align = TextFormatAlign.CENTER ;			
		
			for (var i:* in list) {//i is the Name, list[i] are the points
				text += i + "\t" + list[i] + "\n";
			}
			
			table.width = 200;
			table.height = 150;
			table.mouseEnabled = false;
			table.textColor = utils.colorToUInt(Color.black);
			table.x = game.center.x - table.width/2;
			table.y = game.center.y;
			table.text = text;
			
			table.setTextFormat(format);
			overlays.addChild(s);
			overlays.addChild(table);
		}
		
		public function clearOverlay():void{
			overlays.parent.removeChild(overlays);
			overlayed = false;
		}

		private function overlayLost():void{
			overlayed = true;
			overlays = new Sprite();
			root.addChild(overlays);
			var text:String = "Naub Overflow";
			var layer:* = overlays;
			var message:TextField = new TextField();			
			var format:TextFormat = new TextFormat();
			
			
			format.bold = true;
			format.font = "Verdana";
			format.size = 45;
			format.align = TextFormatAlign.CENTER ;
			
			message.width = 400;
			message.height = 100;
			message.textColor = utils.colorToUInt(Color.red);
			message.x = game.center.x-message.width/2;
			message.y = game.center.y-message.height/2;
			message.text = text;
			message.setTextFormat(format);
			
			layer.addChild(message); 
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
			var js:Sprite = getSprite(j, layers.joints);
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
