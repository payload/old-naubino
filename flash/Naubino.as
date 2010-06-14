﻿package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class Naubino extends Sprite
	{
		public var game : Game;
		private var userInput : UserInput;
		private var visual : Visual;

		private function initFields():void {
			game = new Game();
			mouseChildren = true;
			userInput = new UserInput(this);
			visual = new Visual(this);
		}

		public function Naubino() {
			initFields();
	
			utils.startTimer(game.refreshInterval, game.refresh);
		}
	}
}
