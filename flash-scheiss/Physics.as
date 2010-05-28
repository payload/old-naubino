package{

	class Physics {

		var game : Game;
		const defaultFriction:Number = 0.3;
		const defaultGravity:Number = 0.3;
		
		var gravity:Number = defaultGravity;

		public function Physics(game : Game) {
			this.game = game;
		}

		function indirectGravity(b : Ball) {
			// Vektor v = new Vektor(b.position, getCenter(),
			// b.distanceTo(getCenter()).getLength() * 0.0001 + 0.2);
			var difference:Vektor = game.center.sub(b.position);
			difference = difference.mul(0.0001);
			difference = difference.add(difference.norm.mul(gravity));
			b.accelerate(difference);
		}

		function moveBall(b : Ball){
			b.speed = b.speed.add(b.acceleration);
			b.position = b.position.add(b.speed);
		}

		function friction(b : Ball) {
			b.accelerate(b.speed.mul(-defaultFriction));
		}

		function moveActiveBall(){
			var accel : Vektor = game.pointer.sub(game.active.position);
			game.active.accelerate(accel.mul(0.2));
		}

		function collision(){
			if (game.balls.length > 1) {
				for (var i = 0; i < game.balls.length - 1; i++) {
					for (var j = i + 1; j < game.balls.length; j++) {
						var c:Collision = Collision.test(game.balls[i], game.balls[j]);
						if (c != null) {
							game.attachBalls(c);
							c.collide();
						}
					}
				}
			}
		}
		
		function physik(){
			var i:Number;
			for (i = 0; i < game.balls.length; i++) {
				var b:Ball = game.balls[i];
				b.acceleration = new Vektor();
				indirectGravity(b);
				friction(b);
			}
			
			if (game.active != null)
				moveActiveBall();
			
			for (i = 0; i < 3; i++)
				collision();
				
			for (i = 0; i < game.joints.length; i++) 
				game.joints[i].spring();
				
			for (i = 0; i < game.balls.length; i++) 
				moveBall(game.balls[i]);
		}
	}
}