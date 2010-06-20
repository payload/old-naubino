package stat.es 
{	
	import flash.utils.*;
	import flash.events.*;
	
	public class Help extends GameState
	{
//		private var menuballs:Dictionary;
		
		public function Help(game:Game) 
		{
			super(game);
//			menuballs = new Dictionary();
		}

		public override function enter():void {
			game.visual.help.show();
			game.clear();
			startHelp();
			
			game.menu.exitbtn.setAction(function():void {} ); //we don't want to quit
			game.menu.helpbtn.setAction(function():void {} ); //would only start help again, useless
			game.menu.playbtn.setAction(function():void {changeState(play)});
		}

		public override function leave():void {
			game.visual.help.hide();
			game.clear();	
		}
		
		
		public override function refresh():void {
			game.physics.physik();
		}
		
		public function createPair(v:Vektor, color1:Color, color2:Color):void {
			var obj1:Ball = createBall(color1);
			var obj2:Ball = createBall(color2);
			var obj : Joint = join(obj1, obj2);
			var pair:Vektor = Vektor.polar(Math.random() * Math.PI * 2, obj.length * 0.6);
			var pos1:Vektor = v.add(pair);
			var pos2:Vektor = v.sub(pair);
			obj1.position = pos1;
			obj2.position = pos2;
			game.objs.push(obj);
		}
		
		public function createBall(color:Color, v:Vektor = null):MenuBall {
			if (v == null) v = Vektor.O;
			var b : MenuBall = new MenuBall(v);
			b.game = game;
			b.color = color;
			b.attractedTo = game.center;
			game.objs.push(b);
//			menuballs[b] = v;
			return b;
		}
		
		public function join(a:Naub, b:Naub):Joint {
			var obj:Joint  = new Joint(a, b);
			a.addJoint(obj);
			b.addJoint(obj);
			return obj;
		}
		
		public function startHelp():void {
			game.visual.help.show();			
			createPair(new Vektor(200, 200), Color.green, Color.red);
			createPair(new Vektor(250, 250), Color.green, Color.yellow);
			
		}

	}
}
