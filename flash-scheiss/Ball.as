package 
{
	public class Ball extends Naub
	{
		public var active:Boolean = false;
		
		public override function action():void {
			active = true;
		}
		public function Ball(pos:Vektor, r:Number=defaultRadius) {
			super(pos, r);
			attracted = true;
		}
	}
}