package 
{
	public class Ball extends Naub
	{
		var active:Boolean = false;
		
		public override function action():void {
			active = true;
			trace(color.name);
		}
		public function Ball(pos:Vektor, r:Number=defaultRadius) {
			super(pos, r);
		}
		
		
		
	}
	
}