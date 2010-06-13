import java.util.Random;


class Spammer {
	
	private Game game;
	private Random rand = new Random();
	
	public Spammer(Game game) {
		this.game = game;
	}
	
	public void randomPair() {
		Vektor randPos;
		// TODO randomPair() generiert keine "unten rechts" Baelle
		double xMargin = game.height / 2 - game.getFieldSize() / 2;
		double yMargin = game.width / 2 - game.getFieldSize() / 2;
		switch (rand.nextInt(3)) {
		case 0:
			randPos = new Vektor(rand.nextDouble() * xMargin, rand.nextDouble() * yMargin);
			break;
		case 1:
			randPos = new Vektor(game.width - rand.nextDouble() * xMargin, rand.nextDouble() * yMargin);
			break;
		case 2:
			randPos = new Vektor(rand.nextDouble() * xMargin, game.height - rand.nextDouble() * yMargin);
			break;
		case 3:
			randPos = new Vektor(game.width - rand.nextDouble() * xMargin, game.height - rand.nextDouble() * yMargin);
			System.out.println("unten rechts");
			break;
		default:
			randPos = new Vektor(game.width - rand.nextDouble() * xMargin, game.height - rand.nextDouble() * yMargin);
			System.out.println("unten rechts");
			break;
		}
		game.createPair(randPos);
	}
}
