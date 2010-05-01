package naubino {
public class Main {
    public function start() : void {
	var square:Sprite = new Sprite();
	addChild(square);
	square.graphics.lineStyle(3,0x00ff00);
	square.graphics.beginFill(0x0000FF);
	square.graphics.drawRect(0,0,100,100);
	square.graphics.endFill();
	square.x = stage.stageWidth/2-square.width/2;
	square.y = stage.stageHeight/2-square.height/2;
    }
}
}