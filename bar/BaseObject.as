package
{
	import flash.events.*;
	import flash.display.*;
	
	import mx.messaging.AbstractConsumer;
	
	public class BaseObject
	{
		public var inuse:Boolean = false;
		public var zOrder:int = 0;
		
		public function BaseObject()
		{
			
		}
		
		public function startupBaseObject(zOrder:int):void
		{
			if (!this.inuse)
			{
				this.inuse = true;
				this.zOrder = zOrder;
				GameObjectManager.Instance.addBaseObject(this);
			}
		}
		
		public function shutdown():void
		{
			if (this.inuse)
			{
				this.inuse = false;
				GameObjectManager.Instance.removeBaseObject(this);
			}
		}
		
		public function enterFrame(dt:Number):void
		{
		
		}
		
		public function click(event:MouseEvent):void
		{
		
		}
		
		public function mouseDown(event:MouseEvent):void
		{
		
		}
		
		public function mouseUp(event:MouseEvent):void
		{
		
		}
		
		public function mouseMove(event:MouseEvent):void
		{
		
		}
		
		public function collision(other:BaseObject):void
		{
		
		}
		
		public function copyToBackBuffer(db:BitmapData):void
		{
		
		}

	}
}