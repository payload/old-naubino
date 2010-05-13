import junit.framework.TestCase;


public class VektorTest extends TestCase {

	public void testSub() {
		Vektor v1 = new Vektor(1,0);
		Vektor v2 = new Vektor(0,0);
		Vektor v3 = new Vektor(-1,0);
		assertEquals(v1.sub(v1), v2);
		assertEquals(v2.sub(v1), v3);
	}

}
