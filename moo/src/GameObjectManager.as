package
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import mx.collections.*;
	import mx.core.*;
	
	public class GameObjectManager
	{
		// double buffer
		public var backBuffer:BitmapData;
		// colour to use to clear backbuffer with 
		public var clearColor:uint = 0xFF849AA5;
		// static instance 
		protected static var instance:GameObjectManager = null;
		// the last frame time 
		protected var lastFrame:Date;
		// a collection of the BaseObjects 
		protected var baseObjects:ArrayCollection = new ArrayCollection();
		// a collection where new BaseObjects are placed, to avoid adding items 
		// to baseObjects while in the baseObjects collection while it is in a loop
		protected var newBaseObjects:ArrayCollection = new ArrayCollection();
		// a collection where removed BaseObjects are placed, to avoid removing items 
		// to baseObjects while in the baseObjects collection while it is in a loop
		protected var removedBaseObjects:ArrayCollection = new ArrayCollection();
		protected var collisionMap:Dictionary = new Dictionary();
		
		static public function get Instance():GameObjectManager
		{
			if ( instance == null )
			instance = new GameObjectManager();
			return instance;
		}
		
		public function GameObjectManager()
		{
			if ( instance != null )
				throw new Error( "Only one Singleton instance should be instantiated" ); 
				
			backBuffer = new BitmapData(Application.application.width, Application.application.height, false);
		}
		
		public function startup():void
		{
			lastFrame = new Date();			
		}
		
		public function shutdown():void
		{
			shutdownAll();
		}
		
		public function enterFrame():void
		{
			// Calculate the time since the last frame
			var thisFrame:Date = new Date();
			var seconds:Number = (thisFrame.getTime() - lastFrame.getTime())/1000.0;
	    	lastFrame = thisFrame;
	    	
	    	removeDeletedBaseObjects();
	    	insertNewBaseObjects();
	    	
	    	Level.Instance.enterFrame(seconds);
	    	
	    	checkCollisions();
	    	
	    	// now allow objects to update themselves
			for each (var gameObject:BaseObject in baseObjects)
				if (gameObject.inuse) 
					gameObject.enterFrame(seconds);
	    	
	    	drawObjects();
		}
		
		public function click(event:MouseEvent):void
		{
			for each (var gameObject:BaseObject in baseObjects)
				if (gameObject.inuse) 
					gameObject.click(event);
		}
		
		public function mouseDown(event:MouseEvent):void
		{
			for each (var gameObject:BaseObject in baseObjects)
				if (gameObject.inuse) 
					gameObject.mouseDown(event);
		}
		
		public function mouseUp(event:MouseEvent):void
		{
			for each (var gameObject:BaseObject in baseObjects)
				if (gameObject.inuse) 
					gameObject.mouseUp(event);
		}
		
		public function mouseMove(event:MouseEvent):void
		{
			for each (var gameObject:BaseObject in baseObjects)
				if (gameObject.inuse) 
					gameObject.mouseMove(event);
		}
		
		protected function drawObjects():void
		{
			backBuffer.fillRect(backBuffer.rect, clearColor);
			
			// draw the objects
			for each (var baseObject:BaseObject in baseObjects)
				if (baseObject.inuse)
					baseObject.copyToBackBuffer(backBuffer);
		}
				
		public function addBaseObject(baseObject:BaseObject):void
		{
			newBaseObjects.addItem(baseObject);
		}
		
		public function removeBaseObject(baseObject:BaseObject):void
		{
			removedBaseObjects.addItem(baseObject);
		}
		
		protected function shutdownAll():void
		{
			// don't dispose objects twice
			for each (var baseObject:BaseObject in baseObjects)
			{
				var found:Boolean = false;
				for each (var removedObject:BaseObject in removedBaseObjects)
				{
					if (removedObject == baseObject)
					{
						found = true;
						break;
					}
				}
				
				if (!found)
					baseObject.shutdown();
			}
		}
		
		protected function insertNewBaseObjects():void
		{
			for each (var baseObject:BaseObject in newBaseObjects)
			{
				for (var i:int = 0; i < baseObjects.length; ++i)
				{
					var otherBaseObject:BaseObject = baseObjects.getItemAt(i) as BaseObject;
					
					if (otherBaseObject.zOrder > baseObject.zOrder ||
						otherBaseObject.zOrder == -1)
						break;
				}

				baseObjects.addItemAt(baseObject, i);
			}
			
			newBaseObjects.removeAll();
		}
		
		protected function removeDeletedBaseObjects():void
		{
			// insert the object acording to it's z position
			for each (var removedObject:BaseObject in removedBaseObjects)
			{
				var i:int = 0;
				for (i = 0; i < baseObjects.length; ++i)
				{
					if (baseObjects.getItemAt(i) == removedObject)
					{
						baseObjects.removeItemAt(i);
						break;
					}
				}
				
			}
			
			removedBaseObjects.removeAll();
		}
		
		public function addCollidingPair(collider1:String, collider2:String):void
		{
			if (collisionMap[collider1] == null)			
				collisionMap[collider1] = new Array();
				
			if (collisionMap[collider2] == null)
				collisionMap[collider2] = new Array();
								
			collisionMap[collider1].push(collider2);
			collisionMap[collider2].push(collider1);
		}
		
		protected function checkCollisions():void
		{
	    	for (var i:int = 0; i < baseObjects.length; ++i)
			{
				var gameObjectI:GameObject = baseObjects.getItemAt(i) as GameObject;
				
				if (gameObjectI)
				{				
					for (var j:int = i + 1; j < baseObjects.length; ++j)
					{
						var gameObjectJ:GameObject = baseObjects.getItemAt(j) as GameObject;
						
						if (gameObjectJ)
						{						
							// early out for non-colliders
							var collisionNameNotNothing:Boolean = gameObjectI.collisionName != CollisionIdentifiers.NONE;
							// objects can still exist in the baseObjects collection after being disposed, so check
							var bothInUse:Boolean = gameObjectI.inuse && gameObjectJ.inuse;
							// make sure we have an entry in the collisionMap
							var collisionMapEntryExists:Boolean = collisionMap[gameObjectI.collisionName] != null;
							// make sure the two objects are set to collide
							var testForCollision:Boolean = collisionMapEntryExists && collisionMap[gameObjectI.collisionName].indexOf(gameObjectJ.collisionName) != -1
							
							if ( collisionNameNotNothing &&					
								 bothInUse &&		
								 collisionMapEntryExists &&
								 testForCollision)
							{
								if (gameObjectI.CollisionArea.intersects(gameObjectJ.CollisionArea))
								{
									gameObjectI.collision(gameObjectJ);
									gameObjectJ.collision(gameObjectI);
								}
							}
						}					
					}
				}
			}
		}
	}
}