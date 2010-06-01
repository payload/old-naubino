package 
{
	public class Button extends Ball
	{
		public var _action:Function = function():void{};
		
		public function Button() {
			super(Vektor.O);
			attracted = false;
		}

		public function setAction(action:Function):void {
			_action = action;
		}
		
		public override function action():void {
			_action();
		}
	}
}