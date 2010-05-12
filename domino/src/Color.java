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
}
