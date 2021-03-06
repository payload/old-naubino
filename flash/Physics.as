﻿package{

	public class Physics {

		private var game : Game;
		private const defaultFriction:Number = 0.3;
		private const defaultGravity:Number = 0.3;
		
		public var gravity:Number = defaultGravity;

		public function Physics(game : Game) {
			this.game = game;
		}

		private function indirectGravity(b : Moveable):void {
			if(b.attracted){
				var difference:Vektor = b.attractedTo.sub(b.position);
				difference = difference.mul(0.0001);
				difference = difference.add(difference.norm.mul(gravity));
				b.accelerate(difference);
			}
		}

		private function moveBall(b : Moveable):void {
			b.speed = b.speed.add(b.acceleration);
			b.position = b.position.add(b.speed);
		}

		private function friction(b : Moveable):void {
			b.accelerate(b.speed.mul(-defaultFriction));
		}

		private function moveActiveBall(ball:Ball):void {
			var accel : Vektor = game.pointer.sub(ball.position);
			ball.accelerate(accel.mul(0.35));
		}

		private function collidable(obj:*):Boolean {
			return obj is Physical && obj.collidable;
		}

		private function collide(c:Collision):void {
			game.attachBalls(c);
			c.collide();
		}

		private function collision():void {
			var a:*, b:*;
			for (var i:int = 0; i < (game.objs.length - 1); i++)
			if (collidable(game.objs[i])) {
				for (var j:int = i + 1; j < game.objs.length; j++)
				if (collidable(game.objs[j])) {
					var c:Collision = Collision.test(game.objs[i], game.objs[j]);
					if (c != null) {
						collide(c);
					}
				}
			}
		}

		private function moveable(obj:*):Boolean {
			return obj is Moveable;
		}

		private function handleMoveable(b:Moveable):void {
			b.acceleration = new Vektor();
			indirectGravity(b);
			friction(b);
			if (b is Ball)
				handleBall(b);
		}

		private function handleBall(b:*):void {
			if(b.active)
				moveActiveBall(b);
		}
		
		public function physik():void {
			var i:int, obj:*;
			for (i = 0; i < game.objs.length; i++) {
				obj = game.objs[i];
				if (moveable(obj))
					handleMoveable(obj);
				if (obj is Joint)
					obj.spring();
			}
			
			for (i = 0; i < 1; i++)
				collision();

			for (i = 0; i < game.objs.length; i++) {
				obj = game.objs[i];
				if (moveable(obj))
					moveBall(game.objs[i]);
			}
		}
	}
}
