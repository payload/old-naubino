

package{ class Color {
	var r : Number;
	var g : Number;
	var b : Number;
	var name : String;

	function Color(red:Number, green:Number, blue:Number, n:String) {
		r = red;
		g = green;
		b = blue;
		name = n;
	}

	function equals(other:Color):Boolean {
		return name == other.name;
	}

	/* gibt eine zufällige Farbe aus dem OUTPUT farbschema zurück */
	static var colors:Array = [];

	public static function random():Color {
		if (colors == null) {
			colors.add(red);
			colors.add(green);
			colors.add(pink);
			colors.add(blue);
			colors.add(purple);
			colors.add(yellow);
		}
		var randIndex:Number = Math.floor(Math.random() * colors.length-1); //TODO find nicer replacement for rand.nextInt() in as3.0
		return colors[randIndex];
	}

	static var red:Color = new Color(229, 53, 23, "red");
	static var pink:Color = new Color(226, 0, 122, "pink");
	static var green:Color = new Color(151, 190, 13, "green");
	static var blue:Color = new Color(0, 139, 208, "blue");
	static var purple:Color = new Color(100, 31, 128, "purple");
	static var yellow:Color = new Color(255, 204, 0, "yellow");
	static var black:Color = new Color(0, 0, 0, "black");

	function toString():String {
		return name;
	}
}
}