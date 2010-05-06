

public class Coord{
	float x;
	float y;

  Coord(float x, float y){
    this.x = x;
    this.y = y;
  }
  Coord(){
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
  
  Coord dump(){
    return new Coord(x,y);
  }
}