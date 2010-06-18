package {
	
	import flash.display.*;
	import flash.text.*;

	public class VisualHelp extends VisualModule {
		public function VisualHelp(visual:Visual) {
			super(visual);
		}

		public function show():void {
			visual.show(visual.fog, 2);
		}

		public function hide():void {
			visual.hide(visual.fog, 2);
		}
	}
}