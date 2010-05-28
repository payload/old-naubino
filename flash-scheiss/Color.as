package {
	class Color {
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
		static var colors:Array;

		public static function random():Color {
			if (colors == null) {
				colors = [red, green, pink, blue, yellow, purple];
			}
			var randIndex:uint = Math.ceil(Math.random() * colors.length) - 1; //TODO find nicer replacement for rand.nextInt() in as3.0
			return colors[randIndex];
		}

		static const red   :Color = new Color(229,  53,  23, "red");
		static const pink  :Color = new Color(226,   0, 122, "pink");
		static const green :Color = new Color(151, 190,  13, "green");
		static const blue  :Color = new Color(  0, 139, 208, "blue");
		static const purple:Color = new Color(100,  31, 128, "purple");
		static const yellow:Color = new Color(255, 204,   0, "yellow");
		static const black :Color = new Color(  0,   0,   0, "black");
		static const white :Color = new Color(255, 255, 255, "white");

		function toString():String {
			return name;
		}

	}
}