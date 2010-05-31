package  
{
	public class Map
	{
		public var keys:Array = [];
		public var values:Array = [];
		
		public function take(key:*):* {
			return values[keys.indexOf(key)];
		}
		
		public function put(key:*, value:*):void {
			var i:uint = keys.indexOf(key);
			if (i < 0) {
				keys.push(key);
				values.push(value);
			} else {
				values[i] = value;
			}
		}
		
	}

}