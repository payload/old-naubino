import java.awt.event.KeyEvent;
import processing.*;
import processing.core.PApplet;
import processing.core.PFont;

public class Domino extends PApplet {

	/**
	 * @param args
	 */

	private int frameRate = 50;
	private Game game = Game.instance();
	private int resolutionX = game.width;
	private int resolutionY = game.height;
	private int lineColor = color(0, 0, 0);
	private int backgroundColor = color(255, 255, 255);
	private Coord center = center();
	private Ball draggedBall;

	private PFont myFont;

	private Coord center() {
		return game.getCenter();
	}

	/* setupt des fensters */
	public void setup() {
		size(resolutionX, resolutionY);
		smooth();
		background(backgroundColor);
		frameRate(frameRate);

		stroke(255);
		strokeWeight(2);

		myFont = createFont("FFScala", 12);

	}

	private boolean isInWindow() {
		return (mouseX > 0 && mouseX <= resolutionX && mouseY > 0 && mouseY <= resolutionY);
	}

	/* Steuerung */

	public void mousePressed() {

		if (mouseButton == RIGHT) {
			// game.createTriple(mouseX, mouseY);
			game.createPair(mouseX, mouseY);
		}
	}

	public void mouseDragged() {
		/* TODO do not drag a ball without clicking on it*/
		if (mouseButton == LEFT) {
			if (game.active != null) {
				game.dragActive(mouseX, mouseY);
			} else
				game.active = game.clickedBall(mouseX, mouseY);
		}
	}

	public void mouseReleased() {
		game.active = null;
		if (game.active != null)
			game.active.resetJoints();
	}

	public void keyPressed() {
		if (keyCode == ESC) {
			exit();
		}
		if (keyCode == KeyEvent.VK_SPACE) {
			game.resetBalls();
			game.resetJoints();
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

		ellipse(center.getX(), center.getY(), game.getFieldSize(), game
				.getFieldSize());
		ellipse(center.getX(), center.getY(), 3, 3);
		drawJoints();
		drawBalls();
	}

	private void drawBalls() {
		for (Ball b : game.getBalls()) {
			drawBall(b);
			drawDirection(b);
		}
	}

	private void drawDirection(Ball b) {
		stroke(lineColor);
		strokeWeight(1);
		line(b.position.getX(), b.position.getY(), b.position.getX()
				+ (float) b.speed.getX(), b.position.getY()
				+ (float) b.speed.getY());
	}

	private void drawBall(Ball b) {
		noStroke();
		fill(b.color.r, b.color.g, b.color.b);
		ellipse(b.getX(), b.getY(), b.getR()/2, b.getR()/2);
	}

	private void drawJoints() {
		for (Joint j : game.getJoints()) {
			drawJoint(j);
		}
	}

	private void drawJoint(Joint j) {
		line(j.a.getX(), j.a.getY(), j.b.getX(), j.b.getY());
	}

	/*
	 * Processing Main don't you fuck with that
	 */

	static public void main(String args[]) {
		PApplet.main(new String[] { "--bgcolor=#ffffff", "Domino" });
	}

}
