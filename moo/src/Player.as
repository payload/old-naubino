package
{
	import flash.events.*;
	import flash.geom.*;
	import flash.media.*;
	
	import mx.core.*;

	public class Player extends AnimatedGameObject
	{
		protected static const TimeBetweenShots:Number = 0.25;
		protected var shooting:Boolean = false;
		protected var timeToNextShot:Number = 0;
		
		public function Player()
		{			
			super();
		}
		
		public function startupPlayer():void
		{
			super.startupAnimatedGameObject(ResourceManager.BrownPlaneGraphics, new Point(Application.application.width / 2, Application.application.height / 2), ZOrders.PLAYERZORDER);
			shooting = false;
			timeToNextShot = 0;
			this.collisionName = CollisionIdentifiers.PLAYER;
		}
		
		override public function shutdown():void
		{
			super.shutdown();
		}
		
		override public function enterFrame(dt:Number):void
		{
			super.enterFrame(dt);
			
			timeToNextShot -= dt;
			if (timeToNextShot <= 0 && shooting)
			{
				timeToNextShot = TimeBetweenShots;
				var weapon:Weapon = Weapon.pool.ItemFromPool as Weapon;
				weapon.startupBasicWeapon(
					ResourceManager.TwoBulletsGraphics,
					new Point(
						position.x + graphics.bitmap.width / graphics.frames / 2 - ResourceManager.TwoBulletsGraphics.bitmap.width / 2, 
						position.y),
					150,
					true);
				
				ResourceManager.Gun1FX.play();
			}	
		}
		
		override public function mouseMove(event:MouseEvent):void
		{
			// move player to mouse position
			position.x = event.stageX;
			position.y = event.stageY;
			
			// keep player on the screen
			if (position.x < 0)
				position.x = 0;
			if (position.x > Application.application.width - graphics.bitmap.width / graphics.frames)
				position.x = Application.application.width - graphics.bitmap.width / graphics.frames;
			if (position.y < 0)
				position.y = 0;
			if (position.y > Application.application.height - graphics.bitmap.height )
				position.y = Application.application.height - graphics.bitmap.height ;				
		}
		
		override public function mouseDown(event:MouseEvent):void
		{
			shooting = true;
		}
		
		override public function mouseUp(event:MouseEvent):void
		{
			shooting = false;
		}
		
		override public function collision(other:BaseObject):void
		{
			Level.Instance.levelEnd = true;
			var animatedGameObject:AnimatedGameObject = AnimatedGameObject.pool.ItemFromPool as AnimatedGameObject;
			animatedGameObject.startupAnimatedGameObject(
				ResourceManager.BigExplosionGraphics, 
				new Point(
					position.x + graphics.bitmap.width / graphics.frames / 2 - ResourceManager.BigExplosionGraphics.bitmap.width / ResourceManager.BigExplosionGraphics.frames / 2, 
					position.y + graphics.bitmap.height / 2 - ResourceManager.BigExplosionGraphics.bitmap.height / 2), 
				ZOrders.PLAYERZORDER, 
				true);			
			this.shutdown();
			
			// only play the sound if we didn't crash into an enemy, because an
			// enemy is already playing an explosion sound
			if (other as Enemy == null)
				ResourceManager.ExplosionFX.play();
		}
	}
}