import mx.data.encoders.Num;

class Physics {

	var game: Game;
	var friction:Number = 0.3;
	var gravity:Number = 0.3;

	public Physics(game : Game) {
		//this.game = game;
	}

	function indirectGravity(b : Ball) {
		// Vektor v = new Vektor(b.position, getCenter(),
		// b.distanceTo(getCenter()).getLength() * 0.0001 + 0.2);
		difference:Vektor = game.getCenter().sub(b.position);
		difference = difference.mul(0.0001);
		difference = difference.add(difference.norm().mul(gravity));
		b.accelerate(difference);
	}

	function moveBall(b : Ball){
		b.speed = b.speed.add(b.acceleration);
		b.position = b.position.add(b.speed);
	}

	function friction(b : Ball){
		b.accelerate(b.speed.mul(-friction));
	}

	function moveActiveBall(){
		accel : Vektor = game.getPointer().sub(game.active.position);
		game.active.accelerate(accel.mul(0.2));
	}

	function collision(){
		if (game.balls.size() > 1) {
			var balllist:Array = game.balls.length() - 1;
			 for each (var i:Number in balllist){
				for each (var j:Number in balllist) {
					c:Collision = Collision.test(game.balls[i], game.balls[j]);
					if (c != null) {
						game.attachBalls(c);
						c.collide();
					}
				}
			}
		}
	}
	
	function physik(){

		for (b : Ball : game.balls) {
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
