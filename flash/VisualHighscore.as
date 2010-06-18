package {

	import flash.display.*;
	import flash.text.*;

	public class VisualHighscore extends VisualModule {

		public var highscore:Sprite;
		public var names:TextField;
		public var points:TextField;
		public var names_tf:TextFormat;
		public var points_tf:TextFormat;

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
			format.size = 20;
			format.font = "Verdana";
			format.align = TextFormatAlign.RIGHT;
			names_tf = format;
			format = new TextFormat();
			format.size = 20;
			format.font = "Verdana";
			format.align = TextFormatAlign.LEFT;
			points_tf = format;

			names = new TextField();
			names.autoSize = TextFieldAutoSize.RIGHT;
			names.mouseEnabled = false;
			names.textColor = utils.colorToUInt(Color.black);
			names.x = game.width/2 - 10 - names.width;

			points = new TextField();
			points.autoSize = TextFieldAutoSize.LEFT;
			points.mouseEnabled = false;
		  points.textColor = utils.colorToUInt(Color.black);
			points.x = game.width/2 + 10;
			
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
			table.splice(5, table.length);
		 
			var names_text:String = "";
			var points_text:String = "";
			for (i in table) {
				names_text += table[i].name + "\n";
				points_text += table[i].points + "\n";
			}
			names.text = names_text;
			names.setTextFormat(names_tf);
			names.y = game.center.y - names.height/2;
			points.text = points_text;
			points.setTextFormat(points_tf);
			points.y = game.center.y - points.height/2;
		}
	}
}