package stat.es 
{	
	import flash.utils.*;
	import flash.events.*;
	
	public class Help extends GameState
	{
		private var backup_points:int;
		private var backup_objs:Array = [];

		private var balls:Array = [];
		
		public function Help(game:Game) {
			super(game);
		}

		private var really_backup:Boolean = false;
		private function backup():void {
			if (really_backup) {
				utils.addAll(backup_objs, game.objs);
				backup_points = game.points;
			}
		}

		private function restore():void {
			if (really_backup) {
				game.points = backup_points;
				utils.addAll(game.objs, backup_objs);
			}
		}

		public override function enter():void {
			backup();
			game.clear();
			game.points = 0;
			game.visual.help.show();
			
			helpScreen1();
			
			game.menu.exitbtn.setAction(function():void {} ); //we don't want to quit
			game.menu.helpbtn.setAction(function():void {changeState(play)} ); 
			game.menu.playbtn.setAction(function():void {changeState(play)});
		}

		public override function leave():void {
			game.menu.exitbtn.setAction(game.menu.exitAction);
			game.menu.helpbtn.setAction(game.menu.helpAction);
			
			game.visual.help.hide();
			game.clear();
			game.points = 0;
			restore();
		}
		
		
		public override function refresh():void {
			game.physics.physik();
		}
		
		private function helpScreen1():void {
			game.clear();
			var text:String = "Willkommen!\n" + 
			"Das hier sind 2 Naubs. Versuche, einen Naub mit Hilfe der Maus zu verschieben.";
			game.visual.help.setHelpText(text);
			createPair(game.center, Color.green, Color.red, helpAction1);
		}
		
		private function helpAction1(b:HelpBall):void {
			var distance:Number = game.center.sub(b.position).length;
			if (distance > 30){
				helpScreen2();
				
			}
		}
		
		private function helpScreen2():void {
			game.clear();
			var text:String = "Verbinde die blauen Naubs.";
			game.visual.help.setHelpText(text);

			var temp:Array;
			var i:*;
			temp = createPair(game.center.add(new Vektor(100, 100)), Color.green, Color.red);
			for (i in temp) balls.push(temp[i]);
			temp = createPair(game.center.sub(new Vektor(100, 100)), Color.green, Color.blue);
			for (i in temp) balls.push(temp[i]);
			temp = createPair(new Vektor(200, 200), Color.red, Color.blue, helpAction3);
			for (i in temp) balls.push(temp[i]);					
			for (i in balls) {
				var b:HelpBall = balls[i];
				b.onAttached = helpAction2;
			}
		}
		
		private function helpAction2(b:HelpBall):void {
			helpScreen3();

		}
		
		private function helpScreen3():void {
			var text:String = "Verfahre mit den übrigen Naubs genauso, schließe einen Zyklus.";
			game.visual.help.setHelpText(text);

			var i:*;
			for(i in balls) {
				var b:HelpBall = balls[i];
				b.onRemoved = helpAction3;
			}
		}
		
		private function helpAction3():void{
			helpScreen4();

		}
		
		private function helpScreen4():void{
			var text:String = "Glückwunsch!\nKlicke auf Play, um das Spiel zu beginnen.";
			game.visual.help.setHelpText(text);

		}
		
		public function createPair(v:Vektor, color1:Color, color2:Color, onRelease:Function = null):Array {
			var obj1:HelpBall = createBall(color1);
			var obj2:HelpBall = createBall(color2);
			var obj : Joint = join(obj1, obj2);
			var pair:Vektor = Vektor.polar(Math.random() * Math.PI * 2, obj.length * 0.6);
			var pos1:Vektor = v.add(pair);
			var pos2:Vektor = v.sub(pair);
			obj1.position = pos1;
			obj2.position = pos2;
			
			obj1.onRelease = onRelease;
			obj2.onRelease = onRelease;
			
			game.objs.push(obj);
			return [obj1, obj2];
		}
		
		public function createBall(color:Color, v:Vektor = null):HelpBall {
			if (v == null) v = Vektor.O;
			var b : HelpBall = new HelpBall(v);
			b.game = game;
			b.color = color;
			b.attractedTo = game.center;
			game.objs.push(b);
			return b;
		}
		
		public function join(a:Naub, b:Naub):Joint {
			var obj:Joint  = new Joint(a, b);
			a.addJoint(obj);
			b.addJoint(obj);
			return obj;
		}
	}
}
