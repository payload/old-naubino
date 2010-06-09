package {
	public class Button extends Circle {
		public var popUpX:Number;
		public var popUpY:Number;
		public var alpha:Number = 1;
		public var _type:String;

		public function get type():String{
			return _type;
		}
		public function set type(str:String):void{
			this._type = str;
		}
	}
}
