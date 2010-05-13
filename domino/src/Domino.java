import java.awt.event.KeyEvent;
import java.util.Collection;

import processing.core.*;

public class Domino extends PApplet {

	private static final long serialVersionUID = 7338935826674782250L;

	private int frameRate = 70;
	private Game game = Game.instance();
	private int resolutionX = game.width;
	private int resolutionY = game.height;
	private int lineColor = color(0, 0, 0);
	private int backgroundColor = color(255, 255, 255);
	private Vektor center = center();
	private boolean enableDrawDirection = false;
	private boolean enableDrawNumber = false;

	private PFont myFont;

	private Vektor center() {
		return game.getCenter();
	}

	/* setup des fensters */
	public void setup() {
		size(resolutionX, resolutionY);
		smooth();
		background(backgroundColor);
		frameRate(frameRate);

		stroke(255);
		strokeWeight(2);

		myFont = createFont("FFScala", 12);

	}

	/* Steuerung */

	public void mousePressed() {
		game.setPointer(new Vektor(mouseX, mouseY));
		Vektor v = new Vektor(mouseX, mouseY);
		if (mouseButton == LEFT) {
			game.mousePressedLeft(v);
		} else if (mouseButton == RIGHT) {
			game.mousePressedRight(v);
		}
	}

	public void mouseDragged() {
		game.setPointer(new Vektor(mouseX, mouseY));
	}

	public void mouseReleased() {
		Vektor v = new Vektor(mouseX, mouseY);
		if (mouseButton == LEFT) {
			game.mouseReleasedLeft(v);
		} else if (mouseButton == RIGHT) {
			game.mouseReleasedRight(v);
		}
	}

	// TODO key bindings in an extra class
	public void keyPressed() {
		if (keyCode == ESC) {
			exit();
		}
		if (keyCode == ENTER) {
			game.randomPair();
		}
		if (keyCode == KeyEvent.VK_SPACE) {
			/* just for testing */
			game.restart();
		}
	}

	/* Zeichenvorgang */

	public void draw() {
		noFill();
		background(backgroundColor);
		stroke(lineColor);
		strokeWeight(2);

		textFont(myFont);
		text(game.getNumberOfJoints(), 10, 40);

		/* spielfeld */
		ellipse((float) center.getX(), (float) center.getY(), (float) game.getFieldSize(), (float) game.getFieldSize());
		// ellipse(center.getX(), center.getY(), 3, 3);
		drawJoints();
		drawBalls();
	}

	private void drawDirection(Ball b) {
		stroke(lineColor);
		strokeWeight(1);
		line((float) b.position.getX(), (float) b.position.getY(), (float) b.position.getX() + (float) b.speed.getX(),
				(float) b.position.getY() + (float) b.speed.getY());
	}

	private void drawBalls() {
		Collection<Ball> balls = game.getBalls();
		for (Ball b : balls) {
			drawBall(b);
			if (enableDrawDirection)
				drawDirection(b);
		}
	}

	private void drawBall(Ball b) {
		if (game.active == b)
			this.stroke(1);
		else
			noStroke();
		fill(b.color.r, b.color.g, b.color.b);
		ellipse((float) b.getX(), (float) b.getY(), (float) b.getR() * 2, (float) b.getR() * 2);
		fill(0);
		if (enableDrawNumber)
			text(b.cycleNumber, (float) b.getX(), (float) b.getY());
	}

	private void drawJoints() {
		Collection<Joint> joints = game.getJoints();
		for (Joint j : joints)
			drawJoint(j);
	}

	private void drawJoint(Joint j) {
		// strokeWeight((float) (1 / (j.getStretch() * 0.005)));
		line((float) j.a.getX(), (float) j.a.getY(), (float) j.b.getX(), (float) j.b.getY());
	}

	/*
	 * Processing Main don't you fuck with that
	 */

	static public void main(String args[]) {
		PApplet.main(new String[] { "--bgcolor=#ffffff", "Domino" });
	}

}
