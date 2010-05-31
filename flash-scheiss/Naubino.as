package 
{
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.Font;
	import flash.utils.Timer;
	
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
		
		private function initFields() {
			frameRate = 40;
			game = new Game();
			
			resolutionX = game.width;
			resolutionY = game.height;
			lineColor = Color.black;
			backgroundColor = Color.white;
			enableDrawDirection = false;
			enableDrawNumber = true;
		}
		
		private function startTimer(delay:int, callback:Function):void {
			var timer:Timer = new Timer(delay);
			timer.addEventListener(TimerEvent.TIMER, function(e) { callback() } );
			timer.start();
		}

		public function Naubino() {
			initFields();
			addEventListener(Event.ENTER_FRAME, function(e) { draw() } );
			startTimer(50, game.refresh);
			addEventListener(MouseEvent.MOUSE_DOWN, mousePressed);
			addEventListener(MouseEvent.MOUSE_UP, mouseReleased);
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoved);
			addEventListener(MouseEvent.ROLL_OUT, mouseReleased);
		}

		/* user control */

		private function mousePressed(e:MouseEvent) {
			var v:Vektor = new Vektor(e.stageX, e.stageY);
			game.pointer = v;

			if (!e.altKey)
				game.pointerPressedLeft(v); //left
			else
				game.pointerPressedRight(v);//other than left :P
			
		}

		private function mouseMoved(e:MouseEvent) {
			game.pointerMoved(new Vektor(e.stageX, e.stageY));
		}

		private function mouseReleased(e:MouseEvent) {
			var v:Vektor = new Vektor(e.stageX, e.stageY);
				game.pointerReleasedLeft(v);
		}

		// TODO key bindings in an extra class
		private function keyPressed() {
			/*if (keyCode == ESC)
				exit();
			if (keyCode == ENTER)
				game.keyPressed(0);
			if (keyCode == KeyEvent.VK_SPACE)
				game.keyPressed(1);
			if (keyCode == CONTROL)
				game.keyPressed(2);
			if (keyCode == KeyEvent.VK_Q)
				game.keyPressed(3);
			if (keyCode == KeyEvent.VK_W)
				game.keyPressed(4);*/
		}

		/* drawing */

		private function clear():void {
			for (var i = 0; i < numChildren; i++) {
				removeChildAt(i);
			}
		}
		
		private function draw() {
			clear();
			drawField();
			drawJoints();
			drawBalls();
			drawMenu();
		}
		
		private function drawCircle(x:Number, y:Number, r:Number) {
			graphics.drawCircle(x, y, r);
		}
		
		private function colorToUInt(color:Color):uint {
			return 0x010000 * color.r + 0x000100 * color.g + 0x000001 * color.b;
		}
		
		private function drawText() {
	
		}

		private function drawField():void {
			var bgs:Sprite = new Sprite();
			var fs:Sprite = new Sprite();
			bgs.graphics.beginFill(colorToUInt(backgroundColor));
			bgs.graphics.drawRect(0, 0, game.width, game.height);
			bgs.graphics.endFill();
			fs.graphics.lineStyle(3,colorToUInt(lineColor));
			fs.graphics.drawCircle(game.center.x, game.center.y, game.fieldSize);
			addChild(bgs);
			addChild(fs);
		}
		
		private function drawPointer() {
			/*
			Vektor v = game.getPointer();
			ellipse((float) v.getX(), (float) v.getY(), 5, 5);
			*/
		}

		private function drawDirection(/*Ball b*/) {
			/*
			stroke(lineColor);
			strokeWeight(1);
			line((float) b.position.getX(), (float) b.position.getY(),
					(float) b.position.getX() + (float) b.speed.getX(),
					(float) b.position.getY() + (float) b.speed.getY());
			*/
		}

		private function drawBalls():void {
			game.balls.forEach(drawBall);
		}

		private function drawBall(b:Ball, i=0, _=0):void {
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

		private function drawJoints() {
			game.joints.forEach(drawJoint);
		}

		private function drawJoint(j:Joint, i, _) {
			var js:Sprite = new Sprite();
			js.graphics.lineStyle(2, colorToUInt(lineColor));
			js.graphics.moveTo(j.a.position.x, j.a.position.y);
			js.graphics.lineTo(j.b.position.x, j.b.position.y);
			addChild(js);
		}
		
		private function drawMenu() {
			var menu:Menu = game.menu;
			for (var i = 0; i < menu.buttons.length; i++)
				drawBall(menu.buttons[i]);
		}
	}
}