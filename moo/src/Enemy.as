package
{
	import flash.geom.Point;
	
	import mx.core.*;
	
	public class Enemy extends AnimatedGameObject
	{
		static public var pool:ResourcePool = new ResourcePool(NewEnemy);
		protected var logic:Function = null;
		protected var speed:Number = 0;		
		
		static public function NewEnemy():Enemy
		{
			return new Enemy();
		}
		
		public function Enemy()
		{
			super();
		}

		public function startupBasicEnemy(graphics:GraphicsResource, position:Point, speed:Number):void
		{
			super.startupAnimatedGameObject(graphics, position, ZOrders.PLAYERZORDER);
			
			logic = basicEnemyLogic;
			this.speed = speed;
			this.collisionName = CollisionIdentifiers.ENEMY;
		}
		
		override public function shutdown():void
		{
			super.shutdown();
			logic = null;
		}
		
		override public function enterFrame(dt:Number):void
		{
			super.enterFrame(dt);
			
			if (logic != null)
				logic(dt);
		}
		
		protected function basicEnemyLogic(dt:Number):void
		{
			if (position.y > Application.application.height + graphics.bitmap.height )
				this.shutdown();
			
			position.y += speed * dt;
		}
		
		override public function collision(other:BaseObject):void
		{			
			var animatedGameObject:AnimatedGameObject = AnimatedGameObject.pool.ItemFromPool as AnimatedGameObject;
			animatedGameObject.startupAnimatedGameObject(
				ResourceManager.BigExplosionGraphics, 
				new Point(
					position.x + graphics.bitmap.width / graphics.frames / 2 - ResourceManager.BigExplosionGraphics.bitmap.width / ResourceManager.BigExplosionGraphics.frames / 2, 
					position.y + graphics.bitmap.height / 2 - ResourceManager.BigExplosionGraphics.bitmap.height / 2), 
				ZOrders.PLAYERZORDER, 
				true);
			this.shutdown();
			ResourceManager.ExplosionFX.play();
		}

	}
}