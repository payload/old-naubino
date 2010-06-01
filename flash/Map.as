package  
{
	public class Map
	{
		public var keys:Array = [];
		public var values:Array = [];
		
		public function take(key:*):* {
			var i:int;
			for (i = 0; i < keys.length; i++)
				if (keys[i] === key)
					return values[i];
			return null;
		}
		
		public function put(key:*, value:*):void {
			var i:int;
	 		for (i = keys.length-1; i >= 0; i--)
				if (keys[i] === key)
					break;
			if (i < 0) {
				keys.push(key);
				values.push(value);
			} else {
				values[i] = value;
			}
		}
		
	}

}