import java.awt.event.KeyEvent;
import processing.*;
import processing.core.PApplet;


public class Domino extends PApplet {

	/**
	 * @param args
	 */

	private int resolutionX = 600;
	private int resolutionY = 400;
	private int lineColor = color(0, 0, 0);
	private int backgroundColor = color(255, 255, 255);
	private Coord center = center();
	private Game game = Game.instance();

	private Coord center() {
		return new Coord(resolutionX / 2, resolutionY / 2);
	}

	/* setupt des fensters */
	public void setup() {
		size(resolutionX, resolutionY);
		smooth();
		background(backgroundColor);
		frameRate(5);

		stroke(255);
		strokeWeight(2);
	}

	private boolean isInWindow() {
		return (mouseX > 0 && mouseX <= resolutionX && mouseY > 0 && mouseY <= resolutionY);
	}

	/* Steuerung */

	public void mousePressed() {
		if (mouseButton == LEFT) {
			Ball b = game.clickedBall(mouseX, mouseY);
			if (b != null) {
				game.dragActive(mouseX, mouseY);
			}
		}
		if (mouseButton == RIGHT) {
			game.createTriple(mouseX, mouseY);
			//game.createPair(mouseX, mouseY);
		}
	}

	public void mouseDragged() {
		if (mouseButton == LEFT) {
			Ball b = game.clickedBall(mouseX, mouseY);
			if (b != null) {
				game.dragActive(mouseX, mouseY);
			}
		}
	}

	public void mouseReleased() {
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
		ellipse(center.x, center.y, game.getFieldSize(), game.getFieldSize());
		game.refresh();
		drawJoints();
		drawBalls();
	}

	private void drawBalls() {
		for (Ball b : game.getBalls()) {
			drawBall(b);
		}
	}

	private void drawBall(Ball b) {
		noStroke();
		fill(b.color.r, b.color.g, b.color.b);
		ellipse(b.getX(), b.getY(), b.getR(), b.getR());
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
		PApplet.main(new String[] { "--bgcolor=#000000", "Domino" });
	}

}
