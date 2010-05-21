package 
{
	public class Color {
		
		static var colors : Array;

		static function random():uint {
			
			if (colors == null) {
				colors = [];
				color(229, 53, 23, "red");
				color(226, 0, 122, "pink");
				color(151, 190, 13, "green");
				color(0, 139, 208, "blue");
				color(100, 31, 128, "purple");
				color(255, 204, 0, "yellow");
				color(0, 0, 0, "black");
			}
			return colors[Math.random()*color.length];
		}
		
		static function color(r, g, b, s) {
			var c = r * 0x010000 + g * 0x000100 + b * 0x000001;
			colors.push(c);
		}
	}
}