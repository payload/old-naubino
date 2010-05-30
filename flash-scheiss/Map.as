package  
{
	public class Map
	{
		var keys:Array = [];
		var values:Array = [];
		
		public function take(key:*):* {
			return values[keys.indexOf(key)];
		}
		
		public function put(key:*, value:*):void {
			var i = keys.indexOf(key);
			if (i < 0) {
				keys.push(key);
				values.push(value);
			} else {
				values[i] = value;
			}
		}
		
	}

}