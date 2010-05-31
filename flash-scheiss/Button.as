package 
{
	public class Button extends Ball
	{
		public var _action:Function;
		
		public function Button(position:Vektor, action:Function) {
			super(position);
			_action = action;
			attracted =  0;
		}
		
		public override function action():void {
			_action();
			trace("action()");
		}
	}
	
}