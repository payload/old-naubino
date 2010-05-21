package 
{
	import flash.display.*;
	import flash.events.*;
	import fl.motion.Color;
	import flash.text.Font;
	
	public class Domino extends Sprite
	{
		private var frameRate : int;
		private var game : Game;
		private var resolutionX : int;
		private var resolutionY : int;
		private var lineColor : uint;
		private var backgroundColor : uint;
		private var enableDrawDirection : Boolean;
		private var enableDrawNumber : Boolean;
		private var myFont : Font;
		
		private function initFields() {
			frameRate = 40;
			game = new Game();
			resolutionX = game.width;
			resolutionY = game.height;
			lineColor = 0x000000;
			backgroundColor = 0xFFFFFF;
			enableDrawDirection = false;
			enableDrawNumber = true;
			//myFont = createFont("FFScala", 12);
		}

		public function setup() {
			initFields();
			stage.frameRate = frameRate;
			addEventListener(Event.ENTER_FRAME, this.enterFrame);
		}
		
		function enterFrame(event:Event) {
			draw();
		}

		/* user control */

		private function mousePressed() {
			/*game.setPointer(new Vektor(mouseX, mouseY));
			Vektor v = new Vektor(mouseX, mouseY);
			if (mouseButton == LEFT) {
				game.mousePressedLeft(v);
			} else if (mouseButton == RIGHT) {
				game.mousePressedRight(v);
			}*/
		}

		private function mouseMoved() {
			//game.mouseMoved(new Vektor(mouseX, mouseY));
		}

		private function mouseDragged() {
			//game.mouseMoved(new Vektor(mouseX, mouseY));
		}

		private function mouseReleased() {
			/*Vektor v = new Vektor(mouseX, mouseY);
			if (mouseButton == LEFT) {
				game.mouseReleasedLeft(v);
			} else if (mouseButton == RIGHT) {
				game.mouseReleasedRight(v);
			}*/
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

		private function draw() {
			graphics.clear();
			graphics.beginFill(backgroundColor);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.lineStyle(2, lineColor);
			graphics.drawCircle(game.center.x, game.center.y, game.fieldSize);
			graphics.endFill();

			drawJoints();
			drawBalls();
			drawText();
		}

		private function drawText() {
			/*
			textFont(myFont);

			fill(0);
			textAlign(RIGHT);
			
			text("Physik", 50, 20);
			textAlign(LEFT);
			if (game.enablePhysics) {
				fill(0,200,0);
				text(" an", 50, 20);
			} else{
				fill(200,0,0);
				text(" aus", 50, 20);
			}

			fill(0);
			textAlign(RIGHT);
			
			text("Timer", 50, 34);
			textAlign(LEFT);
			if (game.useGenerateTimer) {
				fill(0,200,0);
				text(" an", 50, 34);
			} else{
				fill(200,0,0);
				text(" aus", 50, 34);
			}

			fill(0);
			textAlign(RIGHT);
			text("Points ", 50, 48);

			textAlign(LEFT);
			text(game.getPoints(), 50, 48);
			
			textAlign(RIGHT);
			text("Field ", 50, 62);

			textAlign(LEFT);
			text(game.getAntiPoints(), 50, 62);
			
			textAlign(RIGHT);
			text("Joints ", 50, 76);

			textAlign(LEFT);
			text(game.getNumberOfJoints(), 50, 76);

			fill(180);
			text(
					"(q)=physik an/aus (w)=timer an/aus (enter)=paar erzeugen (space)=alles lÃ¶schen",
					5, game.height - 5);
			*/
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

		private function drawBalls() {
			game.balls.forEach(drawBall);
		}

		private function drawBall(b:Ball, i, _) {
			graphics.lineStyle(lineColor);
			if (game.active == b)
				graphics.lineStyle(2, 0);
			graphics.beginFill(b.color);
			graphics.drawCircle(b.position.x, b.position.y, b.visibleRadius);
			graphics.endFill();
		}

		private function drawJoints() {
			graphics.lineStyle(4, lineColor);
			game.joints.forEach(drawJoint);
		}

		private function drawJoint(j:Joint, i, _) {
			var x1 = j.a.position.x;
			var y1 = j.a.position.y;
			var x2 = j.b.position.x;
			var y2 = j.b.position.y;
			graphics.moveTo(x1, y1);
			graphics.lineTo(x2, y2);
		}
	}
}