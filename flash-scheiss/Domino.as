package 
{
	import fl.motion.Color;
	import flash.text.Font;
	
	public class Domino
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
			//game = Game.Instance();
			
			resolutionX = game.width;
			resolutionY = game.height;
			lineColor = new Color(0, 0, 0, "black");
			backgroundColor = new Color(1, 1, 1, "white");
			//center = getCenter();
			enableDrawDirection = false;
			enableDrawNumber = true;
			//myFont = createFont("FFScala", 12);
		}

		//private function getCenter() : Vektor {
			//return game.getCenter();
		//}

		private function setup() {
			/*
			size(resolutionX, resolutionY);
			smooth();
			background(backgroundColor);
			frameRate(frameRate);
			
			stroke(255);
			strokeWeight(2);
			*/
			initFields();
			// TODO addEventListener
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
			/*
			noFill();
			background(backgroundColor);
			stroke(lineColor);
			strokeWeight(2);

			// spielfeld
			ellipse((float) center.getX(), (float) center.getY(), (float) game
					.getFieldSize(), (float) game.getFieldSize());
			// ellipse(center.getX(), center.getY(), 3, 3);
			drawJoints();
			drawBalls();
			// drawPointer();
			drawText();
			*/
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
			/*
			Collection<Ball> balls = game.getBalls();
			for (Ball b : balls) {
				drawBall(b);
				if (enableDrawDirection)
					drawDirection(b);
			}
			*/
		}

		private function drawBall(/*Ball b*/) {
			/*
			strokeWeight(2);
			if (game.active == b)
				this.stroke(1);
			else
				noStroke();
			fill(b.color.r, b.color.g, b.color.b);

			ellipse((float) b.getX(), (float) b.getY(),
					(float) b.visibleRadius * 2, (float) b.visibleRadius * 2);

			if (enableDrawNumber) {
				// text(b.ctNumber+" "+b.ctCheck, (float) b.getX()-4, (float)
				// b.getY()+4);
			}*/
		}

		private function drawJoints() {
			/*
			strokeWeight(4);
			stroke(0);
			Collection<Joint> joints = game.getJoints();
			for (Joint j : joints)
				drawJoint(j);
			*/
		}

		private function drawJoint(/*Joint j*/) {
			/*
			// strokeWeight((float) (1 / (j.getStretch() * 0.005)));
			line((float) j.a.getX(), (float) j.a.getY(), (float) j.b.getX(),
					(float) j.b.getY());
			*/
		}
	}
}