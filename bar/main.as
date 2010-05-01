public function creationComplete():void
{
  GameObjectManager.Instance.startup();
}

public function enterFrame(event:Event):void
{
  myCanvas.graphics.clear();
  myCanvas.graphics.beginBitmapFill(GameObjectManager.Instance.backBuffer, null, false, false);
  myCanvas.graphics.drawRect(0, 0, this.width, this.height);
  myCanvas.graphics.endFill();	
}

private function click(event:MouseEvent):void
{
  GameObjectManager.Instance.click(event);
}

private function mouseDown(event:MouseEvent):void
{
  GameObjectManager.Instance.mouseDown(event);
}

private function mouseUp(event:MouseEvent):void
{
  GameObjectManager.Instance.mouseUp(event);
}

private function mouseMove(event:MouseEvent):void
{
  GameObjectManager.Instance.mouseMove(event);
}

