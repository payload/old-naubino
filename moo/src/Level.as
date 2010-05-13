package
{
	import flash.events.*;
	import flash.geom.*;
	import flash.media.*;
	import flash.net.*;
	import flash.utils.*;
	
	import mx.core.*;
	
	public class Level
	{
		protected static var instance:Level = null;
		
		protected static const TimeBetweenLevelElements:Number = 2;
		protected static const TimeBetweenClouds:Number = 2.5;
		protected static const TimeToLevelEnd:Number = 2;
		
		protected var nextDefinitions:Array = null;
		protected var levelID:int = 0;
		protected var totalTime:Number = 0;
		protected var timeToNextCloud:Number = 0;
		protected var timeToLevelEnd:Number = 0;
		protected var backgroundMusic:SoundChannel = null;
		public var levelEnd:Boolean = false;

		static public function get Instance():Level
		{
			if ( instance == null )
				instance = new Level();
			return instance;
		}
		
		public function Level()
		{
	
		}
		
		public function startup(levelID:int):void
		{
			new Player().startupPlayer();
			timeToLevelEnd = TimeToLevelEnd;
			levelEnd = false;
			backgroundMusic = ResourceManager.Track1FX.play(0, int.MAX_VALUE);
			
			this.totalTime = 0;
			this.levelID = levelID;
			nextDefinitions = LevelDefinitions.Instance.getNextLevelDefinitionElements(levelID, 0);
			
			var tileDefinition:TiledBackgroundDefinition = LevelDefinitions.Instance.levelTileMaps[levelID] as TiledBackgroundDefinition;			
			if (tileDefinition != null)
				(TiledBackground.pool.ItemFromPool as TiledBackground).startupTiledBackground(tileDefinition);
		}
		
		public function shutdown():void
		{
			backgroundMusic.stop();
			backgroundMusic = null;
		}
		
		public function enterFrame(dt:Number):void
		{
			totalTime += dt;
			
			if (nextDefinitions == null)
			{
				if (Enemy.pool.NumberOfActiveObjects == 0)
					levelEnd = true;
			}
			else
			{
				var nextLevelDefTime:Number = (nextDefinitions[0] as LevelDefinitionElement).time;
				if (totalTime >= nextLevelDefTime)
				{
					for each (var levelDefElement:LevelDefinitionElement in nextDefinitions)
						levelDefElement.func();
					nextDefinitions = LevelDefinitions.Instance.getNextLevelDefinitionElements(levelID, nextLevelDefTime);
				}
			}
			
			// add cloud
			timeToNextCloud -= dt;
			
			if (timeToNextCloud <= dt)
			{
				timeToNextCloud = TimeBetweenClouds;
				var cloudBackgroundLevelElement:BackgroundLevelElement = BackgroundLevelElement.pool.ItemFromPool as BackgroundLevelElement;
				cloudBackgroundLevelElement.startupBackgroundLevelElement(
					ResourceManager.CloudGraphics, 
					new Point(Math.random() * Application.application.width, -ResourceManager.CloudGraphics.bitmap.height),
					ZOrders.CLOUDSBELOWZORDER,
					75);
			}
			
			if (levelEnd)
			{
				timeToLevelEnd -= dt;
				var scale:Number = timeToLevelEnd / TimeToLevelEnd;
				if (scale < 0) scale = 0;
				var transform:SoundTransform = backgroundMusic.soundTransform;
				transform.volume = scale;
				backgroundMusic.soundTransform = transform;
			}
				
			if (timeToLevelEnd <= 0)
				Application.application.currentState = "LevelEnd";	
		}
	}
}