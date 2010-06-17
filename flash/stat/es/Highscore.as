package stat.es 
{
	import flash.net.*;
	import flash.text.*;

	public class Highscore extends GameState
	{
		public var hallOfFame:Object; // used in Highscore and Visual
		private var submit:Button;

		public function Highscore(game:Game) 
		{
			super(game);
		}

		public override function enter():void {
		
			trace("highscore");
			
			var obj:SharedObject = SharedObject.getLocal("highscore");
			var highscore:Object = obj.data;
			if (obj.size == 0) {
				trace("new highscore");
				highscore["Alice"] = 100;
				highscore["Bob"] = 50;
				highscore["Claire"] = 80;
				highscore["Dave"] = 70;
				highscore["Lasmiranda De'Sivilia"] = 60;
			} else {
				trace("existing highscore");
			}
			hallOfFame = highscore;
			game.menu.mainbtn.setAction(function():void{ changeState(play); });
			initForm();
		}

		private function initForm():void{
			var inputName:TextField = new TextField();
			submit = newButton(Color.random, "submit", function():void{ trace("hell yeah!"); });

			inputName.maxChars = 15;
			inputName.type = TextFieldType.INPUT;
			inputName.border = true;
			inputName.width = 150;
			inputName.height = 20;
			inputName.x = game.center.x-inputName.width/2;
			inputName.y = game.center.y-inputName.height;

			submit.setAction(function():void{trace(inputName.text);});
			submit.color = Color.random;
			submit.x = game.center.x + inputName.width/2 + 20;
			submit.y = inputName.y + 10;
			
			game.visual.overlayNameField(inputName, submit);
			game.visual.overlayList(hallOfFame);
		}

		public override function leave():void {
			game.menu.mainbtn.setAction(function():void{ changeState(highscore); });
			game.objs.splice(game.objs.indexOf(submit),1);
			game.visual.clearOverlay();
		}
		
		private function newButton(color:Color, str:String, action:Function=null):Button {
			var btn : Button = new Button();
			btn.color = color;
			if(action == null)
				btn.setAction(function():void{trace(str)});
			else
				btn.setAction(action);	
			btn.type = str;
			game.objs.push(btn);
			return btn;
		}
	}
}
