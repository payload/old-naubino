import java.util.*;

public class Color {
	public int r;
	public int g;
	public int b;
	public String name;

	Color(int red,int green,int blue){
		r = red;
		g = green;
		b = blue;
		name = "color";
	}
	
	Color(int red,int green,int blue, String n){
		r = red;
		g = green;
		b = blue;
		name = n;
	}
	
	public boolean equals(Color other) {
		return this.name.equals(other.name);
	}
	
	/* gibt eine zufällige Farbe aus dem OUTPUT farbschema zurück */
	private static List<Color> colors;
	private static Random rand = new Random();
	public static Color random() {
		if (colors == null) {
			colors = new ArrayList<Color>();
			colors.add(new Color(229, 53, 23, "red"));
			colors.add(new Color(151, 190, 13, "green"));
			colors.add(new Color(226, 0, 122, "pink"));
			colors.add(new Color(0, 139, 208, "blue"));
			colors.add(new Color(100, 31, 128, "purple"));
			colors.add(new Color(255, 204, 0, "yellow"));
		}
		return colors.get(rand.nextInt(colors.size()));
	}
}
