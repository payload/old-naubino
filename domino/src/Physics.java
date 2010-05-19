
class Physics {

	private Game game;
	private double friction = 0.3;
	private double gravity = 0.3;

	public Physics(Game game) {
		this.game = game;
	}

	private void indirectGravity(Ball b) {
		// Vektor v = new Vektor(b.position, getCenter(),
		// b.distanceTo(getCenter()).getLength() * 0.0001 + 0.2);
		Vektor difference = game.getCenter().sub(b.position);
		difference = difference.mul(0.0001);
		difference = difference.add(difference.norm().mul(gravity));
		b.accelerate(difference);
	}

	private void moveBall(Ball b) {
		b.speed = b.speed.add(b.acceleration);
		b.position = b.position.add(b.speed);
	}

	private void friction(Ball b) {
		b.accelerate(b.speed.mul(-friction));
	}

	private void moveActiveBall() {
		Vektor accel = game.getPointer().sub(game.active.position);
		game.active.accelerate(accel.mul(0.2));
	}

	private void collision() {
		if (game.balls.size() > 1) {
			for (int i = 0; i < game.balls.size() - 1; i++) {
				for (int j = i + 1; j < game.balls.size(); j++) {

					Collision c = Collision.test(game.balls.get(i), game.balls.get(j));
					if (c != null) {
						game.attachBalls(c);
						c.collide();
					}
				}
			}
		}
	}
	
	public void physik() {

		for (Ball b : game.balls) {
			b.acceleration = new Vektor();
			indirectGravity(b);
			friction(b);
		}
		if (game.active != null)
			moveActiveBall();
		for(int i = 0; i < 3; i++)
			collision();
		for (Joint j : game.joints)
			j.spring();
		for (Ball b : game.balls)
			moveBall(b);
	}
}
