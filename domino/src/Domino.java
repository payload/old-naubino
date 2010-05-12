import java.awt.event.KeyEvent;
import processing.core.*;

public class Domino extends PApplet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7338935826674782250L;
	/**
	 * @param args
	 */

	private int frameRate = 70;
	private Game game = Game.instance();
	private int resolutionX = game.width;
	private int resolutionY = game.height;
	private int lineColor = color(0, 0, 0);
	private int backgroundColor = color(255, 255, 255);
	private Vektor center = center();

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
		Vektor v = new Vektor(mouseX, mouseY);
		if (mouseButton == LEFT) {
			game.mouseDownLeft(v);
		} else
		if (mouseButton == RIGHT) {
			game.mouseDownRight(v);
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

		/* spielfeld */
		ellipse((float) center.getX(), (float) center.getY(), (float) game
				.getFieldSize(), (float) game.getFieldSize());
		// ellipse(center.getX(), center.getY(), 3, 3);
		drawJoints();
		drawBalls();
	}

	private void drawDirection(Ball b) {
		stroke(lineColor);
		strokeWeight(1);
		line((float)b.position.getX(), (float)b.position.getY(), (float)b.position.getX()
				+ (float) b.speed.getX(), (float)b.position.getY()
				+ (float) b.speed.getY());
	}

	private void drawBalls() {
		for (Ball b : game.getBalls()) {
			drawBall(b);
			drawDirection(b);
		}
	}

	private void drawBall(Ball b) {
		noStroke();
		fill(b.color.r, b.color.g, b.color.b);
		ellipse((float)b.getX(), (float)b.getY(), (float)b.getR() * 2, (float)b.getR() * 2);
	}

	private void drawJoints() {
		for (Joint j : game.getJoints()) {
			drawJoint(j);
		}
	}

	private void drawJoint(Joint j) {
		// strokeWeight((float) (1 / (j.getStretch() * 0.005)));
		line((float)j.a.getX(), (float)j.a.getY(),(float)j.b.getX(), (float)j.b.getY());
	}

	/*
	 * Processing Main don't you fuck with that
	 */

	static public void main(String args[]) {
		PApplet.main(new String[] { "--bgcolor=#ffffff", "Domino" });
	}

}
