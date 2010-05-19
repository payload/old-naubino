import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

class CycleTest {

	private int ctprogress;
	private Map<Ball, Vertex> vertices;

	private class Vertex {
		public Ball ball;
		public int check = 0;
		public int number = 0;

		public Vertex(Ball b) {
			ball = b;
		}
	}

	public CycleTest(List<Ball> balls) {
		vertices = new HashMap<Ball, Vertex>(balls.size());
		for (Ball b : balls)
			vertices.put(b, new Vertex(b));
	}

	public static List<List<Ball>> cycleTest(List<Ball> balls) {
		return new CycleTest(balls).cycleTest();
	}

	private List<List<Ball>> cycleTest() {
		List<List<Ball>> cycles = new LinkedList<List<Ball>>();
		ctprogress = 1;
		for (Vertex v : vertices.values())
			if (v.number == 0)
				cycles.addAll(cycleTest(v, null));
		return cycles;
	}

	private List<List<Ball>> cycleTest(Vertex v, Vertex pre) {
		List<List<Ball>> l = new LinkedList<List<Ball>>();
		
		v.number = ctprogress;
		ctprogress++;
		v.check = 1;

		List<Vertex> post = getVertices(v.ball.jointBalls());
		if (pre != null)
			post.remove(pre);
		post.remove(v);

		for (Vertex w : post) {
			if (w.number == 0)
				l.addAll(cycleTest(w, v));
			if (w.check == 1)
				l.add(cycleList(v, w));
		}
		v.check = 2;
		
		return l;
	}

	private List<Ball> cycleList(Vertex v, Vertex w) {
		List<Ball> cycle = new LinkedList<Ball>();
		for (Vertex vertex : vertices.values())
			if (vertex.number >= w.number && vertex.check == 1)
				cycle.add(vertex.ball);
		return cycle;
	}
	
	private List<Vertex> getVertices(List<Ball> balls) {
		List<Vertex> r = new ArrayList<Vertex>(balls.size());
		for (Ball b : balls)
			r.add(vertices.get(b));
		return r;
	}

}