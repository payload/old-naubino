package{

	public class Physics {

		private var game : Game;
		private const defaultFriction:Number = 0.3;
		private const defaultGravity:Number = 0.3;
		
		public var gravity:Number = defaultGravity;

		public function Physics(game : Game) {
			this.game = game;
		}

		private function indirectGravity(b : Ball):void {
			if(b.attracted){
				var difference:Vektor = b.attractedTo.sub(b.position);
				difference = difference.mul(0.0001);
				difference = difference.add(difference.norm.mul(gravity));
				b.accelerate(difference);
			}
		}

		private function moveBall(b : Ball):void {
			b.speed = b.speed.add(b.acceleration);
			b.position = b.position.add(b.speed);
		}

		private function friction(b : Ball):void {
			b.accelerate(b.speed.mul(-defaultFriction));
		}

		private function moveActiveBall():void {
			var accel : Vektor = game.pointer.sub(game.active.position);
			game.active.accelerate(accel.mul(0.2));
		}

		private function collision():void {
			if (game.balls.length > 1) {
				for (var i:uint = 0; i < (game.balls.length - 1); i++) {
					for (var j:uint = i + 1; j < game.balls.length; j++) {
						var c:Collision = Collision.test(game.balls[i], game.balls[j]);
						if (c != null) {
							game.attachBalls(c);
							c.collide();
						}
					}
				}
			}
		}
		
		public function physik():void {
			var i:uint;
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