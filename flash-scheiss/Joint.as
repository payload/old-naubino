package 
{
	public class Joint
	{
		var a : Ball;
		var b : Ball;
		
		var length : Number;
		var strength : Number;
		var friction : Number;
		
		static const defaultLength : Number = 40;
		const defaultStrength : Number = 0.3;
		const defaultFriction : Number = 0.3;
		
		function Joint(b1:Ball, b2:Ball,
			length:Number = defaultLength, strength:Number = defaultStrength, friction:Number = defaultFriction) {
			a = b1;
			b = b2;
			this.length = length;
			this.strength = strength;
			this.friction = friction;
		}

		function spring() {
			var springVector = a.position.sub(b.position);
			var force = new Vektor();
			
			var r = springVector.length;
			if(r != 0)
				force = force.add(springVector.norm().mul((length-r)*strength));
			
			force = force.add(a.speed.sub(b.speed).mul(-friction));
			a.accelerate(force);
			b.accelerate(force.mul(-1));
		}
		
		function opposite(b:Ball):Ball {
			if (a == b)
				return this.b;
			else
				return a;
		}
		
		function equals(o:Joint):Boolean {
			if(this.a == o.a && this.b == o.b) return true;
			if(this.a == o.b && this.b == o.a) return true;
			return false;
		}

	}
}