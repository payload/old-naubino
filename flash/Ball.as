﻿package 
{
	import caurina.transitions.Tweener;
	public class Ball extends Naub
	{
		public var active:Boolean = false;
		
		
		public override function action():void {
			active = true;
		}
		
		public function release():void {
			active = false;
		}
		
		public function onAttach():void {
			
		}
		
		public function attachedButRemoved():void {
			
		}
		
		public function onRemove():void{
		
		}
		
		public function Ball(pos:Vektor, r:Number=defaultRadius) {
			super(pos, r);
			attracted = true;
		}
	}
}
