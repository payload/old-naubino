package 
{
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.Font;
	
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

		public function Naubino() {
			initFields();
			addEventListener(Event.ENTER_FRAME, enterFrame);
			addEventListener(MouseEvent.MOUSE_DOWN, mousePressed);
			addEventListener(MouseEvent.MOUSE_UP, mouseReleased);
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoved);
		}
		
		private function enterFrame(e:Event):void {
			draw();
			game.refresh();
		}

		/* user control */

		private function mousePressed(e:MouseEvent) {
			var v:Vektor = new Vektor(e.stageX, e.stageY);
			game.pointer = v;

			if (e.buttonDown)
				game.pointerPressedLeft(v); //left
			else
				game.pointerPressedRight(v);//other than left :P
		}

		private function mouseMoved(e:MouseEvent) {
			game.pointerMoved(new Vektor(e.stageX, e.stageY));
		}

		private function mouseReleased(e:MouseEvent) {
			var v:Vektor = new Vektor(e.stageX, e.stageY);
			if (e.buttonDown)
				game.pointerReleasedLeft(v);
			else 
				game.pointerReleasedRight(v);
			
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
			var fs:Sprite = new Sprite();
			fs.graphics.lineStyle(3,colorToUInt(lineColor));
			fs.graphics.drawCircle(game.center.x, game.center.y, game.fieldSize);
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

		private function drawBall(b:Ball, i, _):void {
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
	}
}