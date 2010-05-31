package 
{
	public class Menu
	{
		var buttons:Array = [];
		
		public function Menu() {
			buttons.push(new Button(new Vektor(35, 30), function () { trace("hallo"); } ));
		}
	}
	
}