import java.util.*;

public class Color {
	public int r;
	public int g;
	public int b;
	public String name;

	Color(int red, int green, int blue) {
		r = red;
		g = green;
		b = blue;
		name = "color";
	}

	Color(int red, int green, int blue, String n) {
		r = red;
		g = green;
		b = blue;
		name = n;
	}

	public boolean equals(Color other) {
		return this.name.equals(other.name);
	}

	public boolean equals(String other) {
		return this.name.equals(other);
	}

	/* gibt eine zufällige Farbe aus dem OUTPUT farbschema zurück */
	private static List<Color> colors;
	private static Random rand = new Random();

	public static Color random() {
		if (colors == null) {
			colors = new ArrayList<Color>();
			colors.add(red);
			colors.add(green);
			colors.add(pink);
			colors.add(blue);
			colors.add(purple);
			colors.add(yellow);
		}
		return colors.get(rand.nextInt(colors.size()));
	}

	public static Color red = new Color(229, 53, 23, "red");
	public static Color pink = new Color(226, 0, 122, "pink");
	public static Color green = new Color(151, 190, 13, "green");
	public static Color blue = new Color(0, 139, 208, "blue");
	public static Color purple = new Color(100, 31, 128, "purple");
	public static Color yellow = new Color(255, 204, 0, "yellow");
	public static Color black = new Color(0, 0, 0, "black");

	public String toString() {
		return name;
	}
}
