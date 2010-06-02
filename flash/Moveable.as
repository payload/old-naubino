package {
	public class Moveable {
		public var position : Vektor;
		public var speed : Vektor;
		public var acceleration : Vektor;
		public var attracted:Boolean;
		public var attractedTo:Vektor;

		public function accelerate(v:Vektor):void {
			acceleration = acceleration.add(v);
		}
	}
}