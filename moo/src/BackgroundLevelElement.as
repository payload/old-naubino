package
{
	import flash.geom.Point;
	import mx.core.*;
	import mx.collections.*;

	public class BackgroundLevelElement extends GameObject
	{
		static public var pool:ResourcePool = new ResourcePool(NewBackgroundLevelElement);
		protected var scrollRate:Number = 0;
		
		static public function NewBackgroundLevelElement():BaseObject
		{
			return new 	BackgroundLevelElement();
		}
		
		public function BackgroundLevelElement()
		{
			super();
		}
		
		public function startupBackgroundLevelElement(bitmap:GraphicsResource, position:Point, z:int, scrollRate:Number):void
		{
			startupGameObject(bitmap, position, z);
			this.scrollRate = scrollRate; 
		}
		
		public override function enterFrame(dt:Number):void
		{
			if (position.y > Application.application.height + graphics.bitmap.height )
				this.shutdown();
			
			position.y += scrollRate * dt;
		}
	}
}