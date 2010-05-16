import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

class CycleTest {
	
	private Game game;
	private int ctprogress;
	
	public CycleTest(Game game) {
		this.game = game;
	}
	
	public void cycleTest() {
		for (Ball b : game.balls) {
			b.ctNumber = 0;
			b.ctCheck = 0;
		}
		ctprogress = 1;
		for (Ball b : game.balls) {
			if (b.ctNumber == 0) {
				cycleTest(b, null);
			}
		}
	}

	public void cycleTest(Ball v, Ball pre) {
		v.ctNumber = ctprogress;
		ctprogress++;
		v.ctCheck = 1;

		List<Ball> post = v.jointBalls();
		if (pre != null)
			post.remove(pre);
		post.remove(v);

		for (Ball w : post) {
			if (w.ctNumber == 0)
				cycleTest(w, v);
			if (w.ctCheck == 1) {
				/* handle cycle */
		for (Ball b : game.balls) {
			if (b.ctCheck == 1) {
				/* TODO sometimes removes too many game.balls */
				// b.color = new Color(0, 0, 0, "black");
				game.removeBall(b);
			}
		}
		// path(v, w);
				game.unJoin(v, w);
			}
		}
		v.ctCheck = 2;
	}
	public void path(Ball a, Ball b) {
		List<Ball> todo = new CopyOnWriteArrayList<Ball>();
		for (Ball jp : a.jointBalls()) {
			if (jp == b) {
				game.removeBall(a);
				game.removeBall(b);
			}

			todo.add(jp);
		}
		for (Ball t : todo) {
			for (Ball jp : t.jointBalls()) {
				if (jp == b) {
					game.removeBall(b);
					path(a, t);
					return;
				} else if (!todo.contains(jp)) {
					todo.add(jp);
				}
			}
		}
	}

}