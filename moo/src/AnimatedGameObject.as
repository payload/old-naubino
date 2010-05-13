package 
{
	import flash.display.*;
	import flash.geom.*;
	import mx.collections.*;

	public class AnimatedGameObject extends GameObject
	{
		static public var pool:ResourcePool = new ResourcePool(NewAnimatedGameObject);
		protected var frameTime:Number = 0;
		protected var currentFrame:int = 0;
		protected var frameWidth:int = 0;
		protected var playOnce:Boolean = false;
		
		static public function NewAnimatedGameObject():AnimatedGameObject
		{
			return new 	AnimatedGameObject();
		}
				
		public function AnimatedGameObject()
		{
			super();		
		}
		
		public function startupAnimatedGameObject(graphics:GraphicsResource, position:Point, z:int = 0, playOnce:Boolean = false):void
		{			
			this.playOnce = playOnce;			
			this.frameWidth = graphics.bitmap.width / graphics.frames;
			
			startupGameObject(graphics, position, z);
		}
		
		override public function enterFrame(dt:Number):void
		{
			if (inuse)
			{
				frameTime += dt;
				if (graphics.fps != -1)
				{
					while (frameTime > 1/graphics.fps)
					{
						frameTime -= 1/graphics.fps;
						currentFrame = (currentFrame + 1) % graphics.frames;
						if (currentFrame == 0 && playOnce)
						{
							shutdown();
							break;
						}
					}
				}
			}
		}
		
		override public function copyToBackBuffer(db:BitmapData):void
		{
			if (inuse)
			{
				var drawRect:Rectangle = new Rectangle(currentFrame * frameWidth, 0, frameWidth, graphics.bitmap.height);
				db.copyPixels(graphics.bitmap, drawRect, position, graphics.bitmapAlpha, new Point(drawRect.x, 0), true);
			}
		}
		
		override protected function setupCollision():void
		{
			collisionArea = new Rectangle(0, 0, frameWidth, graphics.bitmap.height);
		}
	}
	
}