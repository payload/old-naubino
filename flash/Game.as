package 
{
	import caurina.transitions.Tweener;
	import flash.display.JointStyle;
	import flash.events.*;
	//	import flash.utils.Timer;
	import stat.es.*;

	public class Game
	{
		public const width : Number = 600;
		public const height : Number = 400;
		public var points:int = 0;
		public var antipoints:int= 0;
		public var ballsTillLost:int = 30;
		public var refreshInterval:uint = 50;

		public var fieldSize : Number;
		public var objs : Array;
		public var pointer : Vektor;
		public var menu : Menu;
		public var visual : Visual;
		public var naubino : Naubino;
		public var jukebox : Jukebox;

		public var state : GameState;
		public var spammer : Spammer;
		public var physics : Physics;
		public var states:Object = {};

		public var lost:Boolean = false;

		private function initFields():void {
			fieldSize = 160;
			objs = [];
			pointer = center; 
			spammer = new Spammer(this);
			physics = new Physics(this);
			menu = new Menu(this);
			jukebox = new Jukebox();

			states.play = new Play(this);
			states.pause = new Pause(this);
			states.start = new Start(this);
			states.lost = new Lost(this);
			states.help = new Help(this);
			states.highscore = new Highscore(this);
			states.credits = new Credits(this);
			state = states.start;
			state.enter();

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
			state.changeState(states.pause);
		}

		public function clear():void {
			var killlist:Array =[];
			for(var i:uint=0; i<objs.length; i++){
				if(objs[i] is Ball)
					killlist.push(objs[i]);
			}
			for(i=0; i<killlist.length; i++){
				removeBall(killlist[i]);
			}
		}

		public function warn():void{
			var danger:int = ballsTillLost - antipoints;
			var lastDanger:int;
			if(danger < 12)
				visual.startAlert();	
			else if(visual.alertTimer.running)
				visual.stopAlert();
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
							a.active = false;
							if (joinAndReplaceBall(a, b) != null)
								handleCycles();
						}
					} else {
						objs.push(join(a, b));
					}
				}
			}
		}

		private function shareJointNaub(a:Naub, b:Naub):Boolean {
			var naub:Naub;
			var naubs:Array = a.jointNaubs();
			for (var i:* in naubs) {
				naub = naubs[i];
				if (naub.isJointWith(b))
					return true;
			}
			return false;
		}

		// joins two balls
		// * if both naubs are not already joined
		// * if both balls are not joined with the same third ball
		// if it joins two balls
		// * it deletes the second ball
		// * and returns the first
		// else it returns null
		private function joinAndReplaceBall(a:Ball, b:Ball):Ball {
			if (a.isJointWith(b)) return null;
			if (shareJointNaub(a,b)) return null;
			var naubs:Array = b.jointNaubs();
			for (var i:* in naubs) {
				objs.push(join(a, naubs[i]));
			}
			removeBall(b);
			b.attachedButRemoved();
			a.onAttach();
			return a;
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
				cycle[i].onRemove(); 
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
			//createPair(v);
		}

		public function pointerReleasedLeft(v:Vektor):void {
			for (var i:uint = 0; i < objs.length; i++)
				if (objs[i] is Ball)
					if (objs[i].active == true)
						objs[i].release();
		}

		public function pointerReleasedRight(v:Vektor):void {
		}

		public function get center():Vektor {
			return new Vektor(width / 2, height / 2);
		}

		public function get active():Ball {
			if (!(state === states.play || state === states.help))
				return null;
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
