package {

	import flash.display.*;
	import flash.text.*;

	public class VisualHighscore extends VisualModule {

		public var highscore:Sprite;
		public var names:TextField;
		public var points:TextField;
		public var names_tf:TextFormat;
		public var points_tf:TextFormat;
		public var submit:Button;

		public function VisualHighscore(visual:Visual) {
			super(visual);
			initHighscore();
			initReset();
		}

		public function show():void {
			updateHighscoreText();
			if(!visual.game.states.highscore.online)
				visual.game.objs.push(submit);
			visual.show(visual.fog, 2);
			visual.show(highscore, 2);
		}

		public function hide():void {
			visual.hide(visual.fog, 2);
			visual.hide(highscore, 2);
			if(!visual.game.states.highscore.online)
				visual.game.objs.splice(visual.game.objs.indexOf(submit),1);
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
			format = new TextFormat();
			format.size = 40;
			format.bold = true;
			format.font = "Verdana";
			format.align = TextFormatAlign.CENTER;

			var head:TextField;
			head = new TextField();
			head.autoSize = TextFieldAutoSize.CENTER;
			head.mouseEnabled = false;
			head.textColor = Color.yellow.toUInt();
			head.x = game.width/2 - head.width/2;
			head.y = 70;
			head.text = "Highscore";
			head.setTextFormat(format);

			names = new TextField();
			names.autoSize = TextFieldAutoSize.RIGHT;
			names.mouseEnabled = false;
			names.textColor = Color.black.toUInt();
			names.x = game.width/2 - 10 - names.width;

			points = new TextField();
			points.autoSize = TextFieldAutoSize.LEFT;
			points.mouseEnabled = false;
			points.textColor = Color.black.toUInt();
			points.x = game.width/2 + 10;
			
			highscore.addChild(head);
			highscore.addChild(names);
			highscore.addChild(points);
		}	
		private function initReset():void{
				
			submit = new Button();
			submit.color = Color.random;
			submit.setAction(function():void { 
				visual.game.states.highscore.deleteHighscore();
				game.state.changeState(game.states.highscore);
			} );
			submit.x = game.center.x + game.fieldSize;
			submit.y = game.center.y + game.fieldSize;
			submit.type = "reset";

		}	
		private function sort(hall:Array):Array{
			if(hall.length <= 1)
				return hall;
				
			var smaller:Array = [];
			var bigger:Array = [];
			var pi:* = Math.floor(hall.length/2);
			var pivot:* = hall[pi];
			var out:Array = [];
			
			for(var i:* in hall){
				if (i != pi) {
					if(hall[i].points > pivot.points)
						bigger.push(hall[i]);
					else
						smaller.push(hall[i]);
				}
			}
			utils.addAll(out, sort(smaller));
			out.push(pivot);
			utils.addAll(out, sort(bigger));
			return out;
		}

		public function updateHighscoreText():void {
			var i:*;
			var hallOfFame:Array = game.states.highscore.hallOfFame;
			
			hallOfFame = sort(hallOfFame);
			hallOfFame.reverse();
			hallOfFame.splice(5, hallOfFame.length);
		 
			var names_text:String = "";
			var points_text:String = "";
			var rank:int;
			
			for (i in hallOfFame) {
				rank = i+1;
				names_text += rank +" "+ hallOfFame[i].name + "\n";
				points_text += hallOfFame[i].points + "\n";
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
