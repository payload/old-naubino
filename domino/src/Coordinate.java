

public class Coordinate{
	public float x;
	public float y;

	Coordinate(float x, float y){
    this.x = x;
    this.y = y;
  }
	Coordinate(){
  }
  
  void left(float diff){
    this.x = this.x-diff;
  }
  
  void right(float diff){
    this.x = this.x+diff;
  }
    
  void up(float diff){
    this.y = this.y-diff;
  }
  
  void down(float diff){
    this.y = this.y+diff;
  }
  
  Coordinate dump(){
    return new Coordinate(x,y);
  }
}