package {
	public class CycleTest {

		
		private var ctprogress:int;
		private var vertices:Map; //hashmap<Ball, Vertx> hack

		public function CycleTest(balls:Array):void {
			vertices = new Map();
			for (var i:uint = 0; i < balls.length; i++) {
				var b:Ball = balls[i];
				vertices.put(b,new Vertex(b));
			}
		}
		
		
		public static function cycleTest(balls:Array):Array {
			return new CycleTest(balls).cycleTest1();
		}
		
		private function cycleTest1():Array {
			var cycles:Array = [];
			ctprogress = 1;
			var v:Vertex;
			for (var i:uint = 0; i < vertices.keys.length;i++ ) {
				v = vertices.values[i];
				if (v.number == 0){
					utils.addAll(cycles, cycleTest2(v, null));				
				}
			}
			return cycles;
		}

		private function cycleTest2(v:Vertex, pre:Vertex):Array {
			var l:Array = [];
			
			v.number = ctprogress;
			ctprogress++;
			v.check = 1;

			var post:Array = [];
			post = getVertices(v.ball.jointNaubs());
			
			if (pre != null)
				post.splice(post.indexOf(pre),1);

			for (var i:uint = 0; i < post.length;i++){
				var w:Vertex = post[i];
				if (w.number == 0)
					utils.addAll(l,cycleTest2(w, v));
				if (w.check == 1)
					l.push(cycleList(v, w));
			}
			v.check = 2;
			return l;
		}

		private function cycleList(v:Vertex, w:Vertex):Array {
			var cycle:Array = [];
			var vertex:Vertex;
			for (var i:uint = 0; i < vertices.values.length; i++) {
				vertex = vertices.values[i];
				if (vertex.number >= w.number && vertex.check == 1) {
					cycle.push(vertex.ball);
				}
			}
			return cycle;
		}
		
		private function getVertices(balls:Array):Array {
			var r:Array = [];
			var b:Ball ;
			for (var i:uint = 0; i < balls.length; i++){
				b = balls[i];
				r.push(vertices.take(b));
			}
			return r;
		}
	}
}