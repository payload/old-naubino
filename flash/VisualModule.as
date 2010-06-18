package {
	public class VisualModule {

		public var game:Game;
		public var visual:Visual;

		public function VisualModule(visual:Visual) {
			this.game = visual.game;
			this.visual = visual;
		}
	}
}