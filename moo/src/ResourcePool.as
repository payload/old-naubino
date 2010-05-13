package
{
	import mx.collections.*;
	
	public class ResourcePool
	{
		protected var pool:ArrayCollection = new ArrayCollection();
		protected var newObject:Function = null;
		
		public function ResourcePool(newObject:Function)
		{
			this.newObject = newObject;
		}
		
		public function get ItemFromPool():BaseObject
		{
			for each (var item:BaseObject in pool)
			{
				if (!item.inuse)
					return item; 
			}
			
			var newItem:BaseObject = newObject();
			pool.addItem(newItem);
			return newItem;
		}
		
		public function get NumberOfActiveObjects():int
		{
			var count:int = 0;
			for each (var item:BaseObject in pool)
			{
				if (item.inuse)
					++count;
			}
			return count;
		}
	}
}