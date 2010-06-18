package {

	import flash.display.*;
	import flash.text.*;

	public class VisualHighscore extends VisualModule {

		public var highscore:Sprite;
		public var hs_names:TextField;
		public var hs_points:TextField;
		public var hs_names_tf:TextFormat;
		public var hs_points_tf:TextFormat;

		public function VisualHighscore(visual:Visual) {
			super(visual);
			initHighscore();
		}

		public function show():void {
			updateHighscoreText();
			visual.show(visual.fog, 2);
			visual.show(highscore, 2);
		}

		public function hide():void {
			visual.hide(visual.fog, 1);
			visual.hide(highscore, 1);
		}

		public function initHighscore():void {
			highscore = new Sprite();
			visual.overlays.addChild(highscore);
			visual.hide(highscore);
			
			var format:TextFormat;
			format = new TextFormat();
			format.size = 25;
			format.font = "Verdana";
			format.align = TextFormatAlign.RIGHT;
			hs_names_tf = format;
			format = new TextFormat();
			format.size = 20;
			format.font = "Verdana";
			format.align = TextFormatAlign.LEFT;
			hs_points_tf = format;

			hs_names = new TextField();
			var names:TextField = hs_names;
			names.width = game.width/2 - 10;
			names.height = 150;
			names.x = 0;
			names.y = game.center.y - names.height/2;
			names.mouseEnabled = false;
			names.textColor = utils.colorToUInt(Color.black);

			hs_points = new TextField();
			var points:TextField = hs_points;
			points.width = game.width/2 - 10;
			points.height = 150;
			points.x = game.width - points.width;
			points.y = game.center.y - points.height/2;
			points.mouseEnabled = false;
		  points.textColor = utils.colorToUInt(Color.black);
			
			highscore.addChild(names);
			highscore.addChild(points);
		}	

		public function updateHighscoreText():void {
			var i:*;
			var hallOfFame:Object = game.states.highscore.hallOfFame;

			var table:Array = [];
			for (i in hallOfFame) {
				table.push({ name: i, points: hallOfFame[i] });
			}
			table.sortOn("points");
		 
			var names:String = "";
			var points:String = "";
			for (i in table) {
				names += table[i].name + "\n";
				points += table[i].points + "\n";
			}
			hs_names.text = names;
			hs_points.text = points;
			hs_names.setTextFormat(hs_names_tf);
			hs_points.setTextFormat(hs_points_tf);
		}
	}
}