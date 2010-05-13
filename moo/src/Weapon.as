package
{
	import flash.geom.*;
	
	public class Weapon extends GameObject
	{
		static public var pool:ResourcePool = new ResourcePool(NewWeapon);
		protected var logic:Function = null;
		protected var speed:Number = 0;	
		
		static public function NewWeapon():Weapon
		{
			 return new Weapon();
		}
		
		public function Weapon()
		{
			super();
		}
		
		public function startupBasicWeapon(graphics:GraphicsResource, position:Point, speed:Number, playerWeapon:Boolean):void
		{
			super.startupGameObject(graphics, position, ZOrders.PLAYERZORDER);
			
			logic = basicWeaponLogic;
			this.speed = speed;
			
			if (playerWeapon)
				this.collisionName = CollisionIdentifiers.PLAYERWEAPON;
			else
				this.collisionName = CollisionIdentifiers.ENEMYWEAPON;
		}
		
		override public function shutdown():void
		{
			super.shutdown();
			logic = null;
		}
		
		override public function enterFrame(dt:Number):void
		{
			if (logic != null)
				logic(dt);
		}
		
		protected function basicWeaponLogic(dt:Number):void
		{
			if (position.y < -graphics.bitmap.height)
				this.shutdown();
			
			position.y -= speed * dt;
		}
		
		override public function collision(other:BaseObject):void
		{
			this.shutdown();
		}
		
	}
}