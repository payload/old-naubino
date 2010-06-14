package 
{
	import caurina.transitions.Tweener;
	import flash.display.JointStyle;
	import flash.events.*;
	import flash.utils.Timer;
	import stat.es.*;

	public class Game
	{
		public const width : Number = 600;
		public const height : Number = 400;
		public var points:int = 0;
		public var antipoints:int= 0;
		public var ballsTillLost:int = 40;
		public var refreshInterval:uint = 50;

		public var fieldSize : Number;
		public var objs : Array;
		public var pointer : Vektor;
		public var menu : Menu;
		public var naubino : Naubino;
		public var state : GameState;
		public var paused : Pause;
		public var playing : Play;
		public var spammer:Spammer;
		public var physics : Physics;

		public var enablePhysics:Boolean = true;
		public var useGenerateTimer:Boolean  = true;
		public var lost:Boolean = false;

		private function initFields():void {
			fieldSize = 160;
			objs = [];
			pointer = center;
			spammer = new Spammer(this);
			physics = new Physics(this);
			menu = new Menu(this);
			playing = new Play(this);
			paused = new Pause(this);
			state = playing;

		}
		
		public function Game() {
			initFields();
		}
		
		public function createBall(v:Vektor = null):Ball {
			if (v == null) v = Vektor.O;
			var b : Ball = new Ball(v);
			b.attractedTo = center;
			objs.push(b);
			return b;
		}
		
		// objs below here

		public function createPair(v:Vektor):void {
			var obj1:Ball = createBall();
			var obj2:Ball = createBall();
			var obj : Joint = join(obj1, obj2);
			var pair:Vektor = Vektor.polar(Math.random() * Math.PI * 2, obj.length * 0.6);
			var pos1:Vektor = v.add(pair);
			var pos2:Vektor = v.sub(pair);
			obj1.position = pos1;
			obj2.position = pos2;
		  objs.push(obj);
		}

		/* nur benutzen wenn zwei neue Baelle geobj werden */
		public function join(a:Naub, b:Naub):Joint {
			var obj:Joint  = new Joint(a, b);
			a.addJoint(obj);
			b.addJoint(obj);
			return obj;
		}
	
		/* game logic below here */
		public function refresh():void {
			state.refresh();
		}

		public function pause():void {
			state.pause();
		}

		public function clear():void {
			lost = false;
			state = paused;
			var killlist:Array =[];
			for(var i:uint=0; i<objs.length; i++){
				if(objs[i] is Ball)
					killlist.push(objs[i]);
			}
			for(i=0; i<killlist.length; i++){
				removeBall(killlist[i]);
			}
		}

		public function countingJoints():Number {
			var adistance:Number;
			var bdistance:Number;
			var count:Number = 0;
			var fieldRadius:Number = fieldSize ;
			for (var i:uint = 0; i < objs.length; i++) {
				if (objs[i] is Joint) {
					var j:Joint = objs[i];
					adistance = j.a.position.sub(center).length;
					bdistance = j.b.position.sub(center).length;
					if (adistance < fieldRadius || bdistance < fieldRadius)
						count++;
				}
			}
			return count;
		}

		/* objs below here */
		protected function unJoin(a:Ball, b:Ball):void {
			var objs:Array = a.jointsWith(b);
			for(var i:uint = 0; i < objs.length; i++) {
				var j:Joint = objs[i];
				objs.remove(j);
				a.removeJoint(j);
				b.removeJoint(j);
			}
		}

		public function attachBalls(c:Collision):void {
			if (c.a is Ball && c.b is Ball) {
				var a:Ball = Ball(c.a);
				var b:Ball = Ball(c.b);
				if ((a.active || b.active) && c.overlap > 4) {
					if (a.joints.length > 0 && b.joints.length > 0) {
						if ((a is Ball) && (b is Ball) && (a.matches(b))) {
							replaceBall(a, b);
							handleCycles();
						}
					} else {
						objs.push(join(a, b));
					}
				}
			}
		}

		private function replaceBall(a:Ball, b:Ball):void {
			var shareJointBall:Boolean = false;
			var naubs:Array = a.jointNaubs();
			var i:uint;
			var naub:Naub;
			for (i = 0; i < naubs.length; i++) {
				naub = naubs[i];
				if (naub.isJointWith(b))
					shareJointBall = true;
			}
			
			if (!shareJointBall && !a.isJointWith(b)) {
				naubs = b.jointNaubs();
				for (i = 0; i < naubs.length; i++) {
					naub = naubs[i];
					if (!a.isJointWith(naub)) {
						objs.push(join(a, naub));
					}
				}
				removeBall(b);
			}
		}

		private function filter(array:Array, predicate:Function):Array {
			var result : Array = [];
			for (var i:* in array)
				if (predicate(array[i]))
					result.push(array[i]);
			return result;
		}

		private function isFilter(cls:Class):Function {
			return function(x:*):Boolean {
				return x is cls;
			}
		}

		public function get balls():Array {
			return filter(objs, isFilter(Ball));
		}

		public function get joints():Array {
			return filter(objs, isFilter(Joint));
		}

		private function handleCycles():void {
			var cycles:Array = CycleTest.cycleTest(balls);
			for (var i:* in cycles) {
				handleCycle(cycles[i]);
			}
		}
		
		private function handleCycle(cycle:Array):void {
			updatePoints(cycle);
			removeCycle(cycle);
		}

		private function removeCycle(cycle:Array):void {
			var start:Number = 0;
			var step:Number = 0.07;
			for (var i:int = 0; i < cycle.length; i++) {
				shrinkBall(cycle[i], start);
				start += step;
			}
		}

		public var ani_t:Number = 0.5;
		
		private function fadeJoints(joints:Array):void {
			for (var i:int = 0; i < joints.length; i++) {
				fadeOut(joints[i]);
			}
		}

		public function fadeOut(j:Joint):void {
			var tween:Object = {
				size: 0,
				alpha: 0,
				time: ani_t*1.2
			};
			Tweener.addTween(j, tween);
		}
		
		private function shrinkBall(b:Ball, start:Number = 0):void {
			var tween:Object = {
				radius: 0,
				time: ani_t,
				delay: start,
				onStart: function():void { fadeJoints(b.joints); },
				onComplete: function():void { removeBall(b); }
			};
			Tweener.addTween(b, tween);
		}

		private function collidingBall(v:Vektor):Circle  {
			var i:int;
			for (i = 0; i < objs.length; i++) {
				if (objs[i] is Circle) {
					var obj:Circle = objs[i];
					if (obj.isHit(v))
						return obj;
				}
			}
			return null;
		}

		private function removeAll(a:Array, b:Array):void {
			for (var i:uint = 0; i < b.length; i++) {
				var j:Joint = b[i];
				a.splice(a.indexOf(j), 1);
			}
		}
		
		private function removeBall(b:Ball):void {
			removeAll(objs, b.joints);
			var objobjs:Array = b.jointNaubs();
			for (var i:uint = 0; i < objobjs.length; i++) {
				var jp:Ball = objobjs[i];
				removeAll(jp.joints, jp.jointsWith(b));
			}
			objs.splice(objs.indexOf(b), 1);
		}

		/* interaction below here */

		public function pointerMoved(v:Vektor):void {
			pointer = v;
		}

		public function pointerPressedLeft(v:Vektor):void {
			var b:Circle = collidingBall(v);
			if (b != null && b is Action)
				Action(b).action();
		}

		public function pointerPressedRight(v:Vektor):void {
			createPair(v);
		}

		public function pointerReleasedLeft(v:Vektor):void {
			for (var i:uint = 0; i < objs.length; i++)
				if (objs[i] is Ball)
					objs[i].active = false;
		}

		public function pointerReleasedRight(v:Vektor):void {
		}

		public function get center():Vektor {
			return new Vektor(width / 2, height / 2);
		}
		
		public function get active():Ball {
			for (var i:uint = 0; i < objs.length; i++)
				if (objs[i] is Ball && objs[i].active)
					return objs[i];
			return null;
		}
		
		public function updatePoints(cycle:Array):void {
			for (var i:int = 0; i < cycle.length; i++) {
				points++;
			}
		}
	}	
}
