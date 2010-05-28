
class Physics {

	var game: Game;
	var friction:Number = 0.3;
	var gravity:Number = 0.3;

	public Physics(game : Game) {
		//this.game = game;
	}

	function indirectGravity(b : Ball) : void {
		// Vektor v = new Vektor(b.position, getCenter(),
		// b.distanceTo(getCenter()).getLength() * 0.0001 + 0.2);
		difference:Vektor = game.getCenter().sub(b.position);
		difference = difference.mul(0.0001);
		difference = difference.add(difference.norm().mul(gravity));
		b.accelerate(difference);
	}

	function moveBall(Ball b) : void {
		b.speed = b.speed.add(b.acceleration);
		b.position = b.position.add(b.speed);
	}

	function friction(b:Ball) : void {
		b.accelerate(b.speed.mul(-friction));
	}

	function moveActiveBall() : Void {
		Vektor accel = game.getPointer().sub(game.active.position);
		game.active.accelerate(accel.mul(0.2));
	}

	function collision() : void {
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
	
	function physik() : void {

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
