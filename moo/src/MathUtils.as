package
{

	public final class MathUtils
	{
		static public function randRange(start:Number, end:Number) : Number
		{
			return Math.floor(start +(Math.random() * (end - start)));
		}
		
		static public function randomInteger(start:int, end:int) : int
		{
			return Math.round(randRange(start, end));
		}
	}
	
}