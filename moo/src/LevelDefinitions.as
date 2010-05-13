package
{
	import flash.geom.*;
	import flash.utils.*;
	
	public class LevelDefinitions
	{
		protected static var instance:LevelDefinitions = null;
		protected var levelDefinitions:Dictionary = new Dictionary();
		public var levelTileMaps:Dictionary = new Dictionary();
		
		static public function get Instance():LevelDefinitions
		{
			if ( instance == null )
				instance = new LevelDefinitions();
			return instance;
		}
		
		public function LevelDefinitions()
		{
			
		}

		public function addLevelDefinition(levelID:int, element:LevelDefinitionElement):void
		{
			if (levelDefinitions[levelID] == null)
				levelDefinitions[levelID] = new Array();
				
			(levelDefinitions[levelID] as Array).push(element);
			
			levelDefinitions[levelID].sort(LevelDefinitionElement.sort);
		}
		
		public function getNextLevelDefinitionElements(levelID:int, lastTime:Number):Array
		{
			var returnArray:Array = new Array();
			var nextTime:Number = -1;
			
			if (levelDefinitions[levelID] != null)
			{
				for each (var levelDefElement:LevelDefinitionElement in levelDefinitions[levelID])
				{
					if (levelDefElement.time > lastTime && nextTime == -1)
					{
						returnArray.push(levelDefElement);
						nextTime = levelDefElement.time;
					}
					else if (levelDefElement.time == nextTime)
					{
						returnArray.push(levelDefElement);
					}
					else if (levelDefElement.time > nextTime && nextTime != -1)
						break;
				}			
			}
			
			return returnArray.length == 0?null:returnArray;
		}
		
		public function getNextLevelID(levelID:int):int
		{
			if (levelDefinitions[levelID + 1] == null) return 0;
			return levelID + 1;
		}
		
		public function startup():void
		{
			GameObjectManager.Instance.addCollidingPair(CollisionIdentifiers.PLAYER, CollisionIdentifiers.ENEMY);
			GameObjectManager.Instance.addCollidingPair(CollisionIdentifiers.ENEMY, CollisionIdentifiers.PLAYERWEAPON);
			GameObjectManager.Instance.addCollidingPair(CollisionIdentifiers.PLAYER, CollisionIdentifiers.ENEMYWEAPON);

			defineLevel1();
			defineLevel2();			
		}
		
		public function shutdown():void
		{
			
		}
		
		protected function defineLevel1():void
		{
			var level1Tiles:TiledBackgroundDefinition = new TiledBackgroundDefinition();			
			levelTileMaps[1] = level1Tiles;
			level1Tiles.tileScrollRate = 25;
			level1Tiles.tileHeight = 40;
			level1Tiles.tileWidth = 40;
			level1Tiles.tiles = 
				[
					[
						[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID2, ResourceManager.GreenGraphicsID3, ResourceManager.GreenGraphicsID3, ResourceManager.GreenGraphicsID4, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID5, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID7, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID5, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID7, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID5, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID7, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID8, ResourceManager.GreenGraphicsID9, ResourceManager.GreenGraphicsID9, ResourceManager.GreenGraphicsID10, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
						,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					]
					,[
						[null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
						,[null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
						,[null, ResourceManager.GreenGraphicsID11, ResourceManager.GreenGraphicsID12, ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID14, ResourceManager.GreenGraphicsID15, ResourceManager.GreenGraphicsID16, null, null, null, null, null, null, null, null]
						,[null, ResourceManager.GreenGraphicsID17, ResourceManager.GreenGraphicsID18, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID20, ResourceManager.GreenGraphicsID21, ResourceManager.GreenGraphicsID22, null, null, null, null, null, null, null, null]
						,[null, ResourceManager.GreenGraphicsID23, ResourceManager.GreenGraphicsID24, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID26, ResourceManager.GreenGraphicsID27, null, null, null, null, null, null, null, null]
						,[null, ResourceManager.GreenGraphicsID28, ResourceManager.GreenGraphicsID29, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID30, ResourceManager.GreenGraphicsID31, null, null, null, null, null, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33]
						,[null, ResourceManager.GreenGraphicsID34, ResourceManager.GreenGraphicsID35, ResourceManager.GreenGraphicsID36, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID38, ResourceManager.GreenGraphicsID39, null, null, null, null, null, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41]
						,[null, ResourceManager.GreenGraphicsID42, ResourceManager.GreenGraphicsID43, ResourceManager.GreenGraphicsID44, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID46, ResourceManager.GreenGraphicsID47, ResourceManager.GreenGraphicsID11, ResourceManager.GreenGraphicsID12, ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID14, ResourceManager.GreenGraphicsID15, ResourceManager.GreenGraphicsID16, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49]
						,[null, ResourceManager.GreenGraphicsID50, ResourceManager.GreenGraphicsID51, ResourceManager.GreenGraphicsID52, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID54, ResourceManager.GreenGraphicsID55, ResourceManager.GreenGraphicsID17, ResourceManager.GreenGraphicsID18, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID20, ResourceManager.GreenGraphicsID21, ResourceManager.GreenGraphicsID22, null, null]
						,[null, null, null, null, null, null, null, ResourceManager.GreenGraphicsID23, ResourceManager.GreenGraphicsID24, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID26, ResourceManager.GreenGraphicsID27, null, null]
						,[null, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, null, null, ResourceManager.GreenGraphicsID28, ResourceManager.GreenGraphicsID29, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID30, ResourceManager.GreenGraphicsID31, null, null]
						,[null, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, null, ResourceManager.GreenGraphicsID34, ResourceManager.GreenGraphicsID35, ResourceManager.GreenGraphicsID36, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID38, ResourceManager.GreenGraphicsID39, null, null]
						,[null, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, null, null, ResourceManager.GreenGraphicsID42, ResourceManager.GreenGraphicsID43, ResourceManager.GreenGraphicsID44, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID46, ResourceManager.GreenGraphicsID47, null, null]
						,[null, null, null, null, null, null, null, ResourceManager.GreenGraphicsID50, ResourceManager.GreenGraphicsID51, ResourceManager.GreenGraphicsID52, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID54, ResourceManager.GreenGraphicsID55, null, null]
						,[null, ResourceManager.GreenGraphicsID11, ResourceManager.GreenGraphicsID12, ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID14, ResourceManager.GreenGraphicsID15, ResourceManager.GreenGraphicsID16, null, null, null, null, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null]
						,[null, ResourceManager.GreenGraphicsID17, ResourceManager.GreenGraphicsID18, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID20, ResourceManager.GreenGraphicsID21, ResourceManager.GreenGraphicsID22, null, null, null, null, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null]
						,[null, ResourceManager.GreenGraphicsID23, ResourceManager.GreenGraphicsID24, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID26, ResourceManager.GreenGraphicsID27, null, null, null, null, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null]
						,[null, ResourceManager.GreenGraphicsID28, ResourceManager.GreenGraphicsID29, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID30, ResourceManager.GreenGraphicsID31, null, null, null, null, null, null, null, null]
						,[null, ResourceManager.GreenGraphicsID34, ResourceManager.GreenGraphicsID35, ResourceManager.GreenGraphicsID36, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID38, ResourceManager.GreenGraphicsID39, null, ResourceManager.GreenGraphicsID11, ResourceManager.GreenGraphicsID12, ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID14, ResourceManager.GreenGraphicsID15, ResourceManager.GreenGraphicsID16, null]
						,[null, ResourceManager.GreenGraphicsID42, ResourceManager.GreenGraphicsID43, ResourceManager.GreenGraphicsID44, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID46, ResourceManager.GreenGraphicsID47, null, ResourceManager.GreenGraphicsID17, ResourceManager.GreenGraphicsID18, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID20, ResourceManager.GreenGraphicsID21, ResourceManager.GreenGraphicsID22, null]
						,[null, ResourceManager.GreenGraphicsID50, ResourceManager.GreenGraphicsID51, ResourceManager.GreenGraphicsID52, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID54, ResourceManager.GreenGraphicsID55, null, ResourceManager.GreenGraphicsID23, ResourceManager.GreenGraphicsID24, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID26, ResourceManager.GreenGraphicsID27, null]
						,[null, null, null, null, null, null, null, null, ResourceManager.GreenGraphicsID28, ResourceManager.GreenGraphicsID29, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID25, ResourceManager.GreenGraphicsID30, ResourceManager.GreenGraphicsID31, null]
						,[null, null, null, null, null, null, null, null, ResourceManager.GreenGraphicsID34, ResourceManager.GreenGraphicsID35, ResourceManager.GreenGraphicsID36, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID38, ResourceManager.GreenGraphicsID39, null]
						,[null, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, null, null, null, ResourceManager.GreenGraphicsID42, ResourceManager.GreenGraphicsID43, ResourceManager.GreenGraphicsID44, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID46, ResourceManager.GreenGraphicsID47, null]
						,[null, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, null, null, ResourceManager.GreenGraphicsID50, ResourceManager.GreenGraphicsID51, ResourceManager.GreenGraphicsID52, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID54, ResourceManager.GreenGraphicsID55, null]
						,[null, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, null, null, null, null, null, null, null, null]
						,[null, null, null, null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, null, null, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, null, null]
						,[null, null, null, null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, null, null, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, null]
						,[null, null, null, null, ResourceManager.GreenGraphicsID11, ResourceManager.GreenGraphicsID12, ResourceManager.GreenGraphicsID15, ResourceManager.GreenGraphicsID16, null, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, null, null]
						,[null, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, ResourceManager.GreenGraphicsID17, ResourceManager.GreenGraphicsID18, ResourceManager.GreenGraphicsID21, ResourceManager.GreenGraphicsID22, null, null, null, null, null, null, null]
						,[null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, ResourceManager.GreenGraphicsID23, ResourceManager.GreenGraphicsID24, ResourceManager.GreenGraphicsID30, ResourceManager.GreenGraphicsID31, null, null, null, null, null, null, null]
						,[null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, ResourceManager.GreenGraphicsID34, ResourceManager.GreenGraphicsID35, ResourceManager.GreenGraphicsID38, ResourceManager.GreenGraphicsID39, null, ResourceManager.GreenGraphicsID11, ResourceManager.GreenGraphicsID12, ResourceManager.GreenGraphicsID15, ResourceManager.GreenGraphicsID16, null, null]
						,[null, null, null, null, ResourceManager.GreenGraphicsID42, ResourceManager.GreenGraphicsID43, ResourceManager.GreenGraphicsID46, ResourceManager.GreenGraphicsID47, null, ResourceManager.GreenGraphicsID17, ResourceManager.GreenGraphicsID18, ResourceManager.GreenGraphicsID21, ResourceManager.GreenGraphicsID22, null, null]
						,[null, null, null, null, ResourceManager.GreenGraphicsID50, ResourceManager.GreenGraphicsID51, ResourceManager.GreenGraphicsID54, ResourceManager.GreenGraphicsID55, null, ResourceManager.GreenGraphicsID23, ResourceManager.GreenGraphicsID24, ResourceManager.GreenGraphicsID30, ResourceManager.GreenGraphicsID31, null, null]
						,[null, null, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, null, null, null, ResourceManager.GreenGraphicsID34, ResourceManager.GreenGraphicsID35, ResourceManager.GreenGraphicsID38, ResourceManager.GreenGraphicsID39, null, null]
						,[null, null, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, null, null, ResourceManager.GreenGraphicsID42, ResourceManager.GreenGraphicsID43, ResourceManager.GreenGraphicsID46, ResourceManager.GreenGraphicsID47, null, null]
						,[null, null, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, ResourceManager.GreenGraphicsID50, ResourceManager.GreenGraphicsID51, ResourceManager.GreenGraphicsID54, ResourceManager.GreenGraphicsID55, null, null]
						,[null, ResourceManager.GreenGraphicsID11, ResourceManager.GreenGraphicsID12, ResourceManager.GreenGraphicsID15, ResourceManager.GreenGraphicsID16, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, null, null, null, null, null]
						,[null, ResourceManager.GreenGraphicsID17, ResourceManager.GreenGraphicsID18, ResourceManager.GreenGraphicsID21, ResourceManager.GreenGraphicsID22, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, null, null, null]
						,[null, ResourceManager.GreenGraphicsID23, ResourceManager.GreenGraphicsID24, ResourceManager.GreenGraphicsID30, ResourceManager.GreenGraphicsID31, null, null, null, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, null, null]
						,[null, ResourceManager.GreenGraphicsID34, ResourceManager.GreenGraphicsID35, ResourceManager.GreenGraphicsID38, ResourceManager.GreenGraphicsID39, null, null, null, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, null, null, null]
						,[null, ResourceManager.GreenGraphicsID42, ResourceManager.GreenGraphicsID43, ResourceManager.GreenGraphicsID46, ResourceManager.GreenGraphicsID47, null, null, null, null, null, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, null]
						,[null, ResourceManager.GreenGraphicsID50, ResourceManager.GreenGraphicsID51, ResourceManager.GreenGraphicsID54, ResourceManager.GreenGraphicsID55, null, null, null, null, null, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null]
						,[null, null, null, null, null, null, null, null, null, null, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, null]
						,[null, null, null, null, null, null, null, null, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, null, null, null, null]
						,[null, null, null, null, null, null, null, null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, null, null, null, null]
						,[null, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, null, null, null, null]
						,[null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, null, null, null, null, null, null]
						,[null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, null, null, null, null, null, null, null]
					]
				];

			LevelDefinitions.Instance.addLevelDefinition(
				1, 
				new LevelDefinitionElement(
					4,
					function():void 
					{
						for each (var xPos:int in [150, 350])
						{
							(Enemy.pool.ItemFromPool as Enemy).startupBasicEnemy(
								ResourceManager.SmallBluePlaneGraphics,
								new Point(xPos, -ResourceManager.SmallBluePlaneGraphics.bitmap.height),
								55);
						}
					}
				));
			LevelDefinitions.Instance.addLevelDefinition(
				1, 
				new LevelDefinitionElement(
					5,
					function():void {(Enemy.pool.ItemFromPool as Enemy).startupBasicEnemy(
						ResourceManager.SmallBluePlaneGraphics,
						new Point(500, -ResourceManager.SmallBluePlaneGraphics.bitmap.height),
						55);}));
			LevelDefinitions.Instance.addLevelDefinition(
				1, 
				new LevelDefinitionElement(
					7,
					function():void 
					{
						for each (var xPos:int in [30, 60, 90, 120, 150])
						{
							(Enemy.pool.ItemFromPool as Enemy).startupBasicEnemy(
							ResourceManager.SmallBluePlaneGraphics,
							new Point(xPos, -ResourceManager.SmallBluePlaneGraphics.bitmap.height),
							55);
						}
					}));
			LevelDefinitions.Instance.addLevelDefinition(
				1, 
				new LevelDefinitionElement(
					12,
					function():void 
					{
						for each (var xPos:int in [120, 150, 180, 210, 240])
						{
							(Enemy.pool.ItemFromPool as Enemy).startupBasicEnemy(
							ResourceManager.SmallBluePlaneGraphics,
							new Point(xPos, -ResourceManager.SmallBluePlaneGraphics.bitmap.height),
							55);
						}
					}));
			LevelDefinitions.Instance.addLevelDefinition(
				1, 
				new LevelDefinitionElement(
					17,
					function():void 
					{
						for each (var xPos:int in [240, 270, 300, 330, 360])
						{
							(Enemy.pool.ItemFromPool as Enemy).startupBasicEnemy(
							ResourceManager.SmallBluePlaneGraphics,
							new Point(xPos, -ResourceManager.SmallBluePlaneGraphics.bitmap.height),
							55);
						}
					}));
			LevelDefinitions.Instance.addLevelDefinition(
				1, 
				new LevelDefinitionElement(
					23,
					function():void 
					{
						for each (var xPos:int in [360, 390, 420, 450, 480])
						{
							(Enemy.pool.ItemFromPool as Enemy).startupBasicEnemy(
							ResourceManager.SmallBluePlaneGraphics,
							new Point(xPos, -ResourceManager.SmallBluePlaneGraphics.bitmap.height),
							55);
						}
					}));
			LevelDefinitions.Instance.addLevelDefinition(
				1, 
				new LevelDefinitionElement(
					28,
					function():void 
					{
						for each (var xPos:int in [480, 510, 540, 570])
						{
							(Enemy.pool.ItemFromPool as Enemy).startupBasicEnemy(
							ResourceManager.SmallBluePlaneGraphics,
							new Point(xPos, -ResourceManager.SmallBluePlaneGraphics.bitmap.height),
							55);
						}
					}));															
		}
		
		protected function defineLevel2():void
		{
			var level2Tiles:TiledBackgroundDefinition = new TiledBackgroundDefinition();			
			levelTileMaps[2] = level2Tiles;
			level2Tiles.tileScrollRate = 25;
			level2Tiles.tileHeight = 40;
			level2Tiles.tileWidth = 40;
			level2Tiles.tiles = 			
			[
				[
					[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID2, ResourceManager.GreenGraphicsID3]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID5, ResourceManager.GreenGraphicsID6]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID5, ResourceManager.GreenGraphicsID6]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID2, ResourceManager.GreenGraphicsID65, ResourceManager.GreenGraphicsID6]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID5, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID2, ResourceManager.GreenGraphicsID3, ResourceManager.GreenGraphicsID65, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6]
					,[ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID1, ResourceManager.GreenGraphicsID5, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6]
					,[ResourceManager.GreenGraphicsID3, ResourceManager.GreenGraphicsID3, ResourceManager.GreenGraphicsID3, ResourceManager.GreenGraphicsID3, ResourceManager.GreenGraphicsID3, ResourceManager.GreenGraphicsID3, ResourceManager.GreenGraphicsID3, ResourceManager.GreenGraphicsID3, ResourceManager.GreenGraphicsID3, ResourceManager.GreenGraphicsID3, ResourceManager.GreenGraphicsID65, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6]
					,[ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6]
					,[ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6]
					,[ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6]
					,[ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6]
					,[ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6]
					,[ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6, ResourceManager.GreenGraphicsID6]
				]
				,[
					[null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
					,[null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
					,[null, null, null, null, null, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, null, null, null, null, null, null]
					,[null, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, null, null, null, null, null]
					,[null, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, null, null, null, null, null, null]
					,[null, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, null, null, null, null, null, null, null, null, null, null]
					,[null, null, null, null, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, null, null, null, null, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, null]
					,[null, null, null, null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, null, null, null, null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, null]
					,[ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, null]
					,[ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, null, null, null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, null, null, null, null, null]
					,[ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, null, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, null, null, null, null, null]
					,[null, null, null, null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, null, null, null, null, null, null, null, null]
					,[null, null, null, null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, null, null, null, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, null, null]
					,[null, null, ResourceManager.GreenGraphicsID11, ResourceManager.GreenGraphicsID12, ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID14, ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID15, ResourceManager.GreenGraphicsID16, null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, ResourceManager.GreenGraphicsID11, ResourceManager.GreenGraphicsID12]
					,[null, null, ResourceManager.GreenGraphicsID17, ResourceManager.GreenGraphicsID18, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID20, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID21, ResourceManager.GreenGraphicsID22, null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, ResourceManager.GreenGraphicsID17, ResourceManager.GreenGraphicsID18]
					,[null, null, ResourceManager.GreenGraphicsID23, ResourceManager.GreenGraphicsID24, ResourceManager.GreenGraphicsID20, ResourceManager.GreenGraphicsID20, ResourceManager.GreenGraphicsID20, ResourceManager.GreenGraphicsID30, ResourceManager.GreenGraphicsID31, null, null, null, null, ResourceManager.GreenGraphicsID23, ResourceManager.GreenGraphicsID24]
					,[null, null, ResourceManager.GreenGraphicsID34, ResourceManager.GreenGraphicsID35, ResourceManager.GreenGraphicsID36, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID38, ResourceManager.GreenGraphicsID39, null, null, null, null, ResourceManager.GreenGraphicsID23, ResourceManager.GreenGraphicsID24]
					,[null, null, ResourceManager.GreenGraphicsID42, ResourceManager.GreenGraphicsID43, ResourceManager.GreenGraphicsID44, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID46, ResourceManager.GreenGraphicsID47, null, null, null, null, ResourceManager.GreenGraphicsID23, ResourceManager.GreenGraphicsID24]
					,[null, null, ResourceManager.GreenGraphicsID50, ResourceManager.GreenGraphicsID51, ResourceManager.GreenGraphicsID52, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID54, ResourceManager.GreenGraphicsID55, null, null, null, null, ResourceManager.GreenGraphicsID23, ResourceManager.GreenGraphicsID24]
					,[null, null, null, null, null, null, null, null, null, null, null, null, null, ResourceManager.GreenGraphicsID34, ResourceManager.GreenGraphicsID35]
					,[null, null, null, ResourceManager.GreenGraphicsID11, ResourceManager.GreenGraphicsID12, ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID13, null, null, null, null, null, null, ResourceManager.GreenGraphicsID42, ResourceManager.GreenGraphicsID43]
					,[null, null, null, ResourceManager.GreenGraphicsID17, ResourceManager.GreenGraphicsID18, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID21, ResourceManager.GreenGraphicsID22, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, ResourceManager.GreenGraphicsID50, ResourceManager.GreenGraphicsID51]
					,[null, null, null, ResourceManager.GreenGraphicsID34, ResourceManager.GreenGraphicsID35, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID38, ResourceManager.GreenGraphicsID39, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, null]
					,[null, null, null, ResourceManager.GreenGraphicsID42, ResourceManager.GreenGraphicsID43, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID46, ResourceManager.GreenGraphicsID47, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, null, null]
					,[null, null, null, ResourceManager.GreenGraphicsID50, ResourceManager.GreenGraphicsID51, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID54, ResourceManager.GreenGraphicsID55, null, null, null, null, null, null]
					,[null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, null, null, null, null, null, null, null, null, null, null, null]
					,[null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, null, null, null, null, null, null, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null]
					,[null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, null, null, null, null, null, null, null, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null]
					,[null, null, null, null, null, null, null, null, null, null, null, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null]
					,[null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
					,[ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID14, ResourceManager.GreenGraphicsID14, ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID14, ResourceManager.GreenGraphicsID14, ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID14, ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID14, ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID13, ResourceManager.GreenGraphicsID13]
					,[ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID20, ResourceManager.GreenGraphicsID20, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID20, ResourceManager.GreenGraphicsID20, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID20, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID20, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID19, ResourceManager.GreenGraphicsID19]
					,[ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID36, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID36, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID36, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID36, ResourceManager.GreenGraphicsID37, ResourceManager.GreenGraphicsID36, ResourceManager.GreenGraphicsID37]
					,[ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID44, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID44, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID44, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID44, ResourceManager.GreenGraphicsID45, ResourceManager.GreenGraphicsID44, ResourceManager.GreenGraphicsID45]
					,[ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID52, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID52, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID52, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID52, ResourceManager.GreenGraphicsID53, ResourceManager.GreenGraphicsID52, ResourceManager.GreenGraphicsID53]
					,[null, null, null, null, null, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, null, null, null, null, null, null, null]
					,[null, null, null, null, null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, null, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, null, null, null]
					,[null, null, null, null, null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, null, null, null]
					,[null, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, null, null, null, null, null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, null, null, null]
					,[null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, null, null, null, null, null, null, null, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, null]
					,[null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, null, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, null, null, null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, null]
					,[null, null, null, null, null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, null, null, null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, null]
					,[null, null, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, null, null, null, null, null, null, null]
					,[null, null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, null, null, null]
					,[null, null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, null, null]
					,[null, null, null, null, null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, null, null, null]
					,[null, null, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, null, ResourceManager.GreenGraphicsID32, ResourceManager.GreenGraphicsID33, null, null, null, ResourceManager.GreenGraphicsID56, ResourceManager.GreenGraphicsID57, ResourceManager.GreenGraphicsID58]
					,[null, null, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, ResourceManager.GreenGraphicsID40, ResourceManager.GreenGraphicsID41, null, null, null, ResourceManager.GreenGraphicsID59, ResourceManager.GreenGraphicsID60, ResourceManager.GreenGraphicsID61]
					,[null, null, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, null, ResourceManager.GreenGraphicsID48, ResourceManager.GreenGraphicsID49, null, null, null, ResourceManager.GreenGraphicsID62, ResourceManager.GreenGraphicsID63, ResourceManager.GreenGraphicsID64]
				]
			];						
											
			LevelDefinitions.Instance.addLevelDefinition(
				2, 
				new LevelDefinitionElement(
					1,
					function():void {(Enemy.pool.ItemFromPool as Enemy).startupBasicEnemy(
						ResourceManager.SmallGreenPlaneGraphics,
						new Point(100, -ResourceManager.SmallGreenPlaneGraphics.bitmap.height),
						55);}));
			LevelDefinitions.Instance.addLevelDefinition(
				2, 
				new LevelDefinitionElement(
					3,
					function():void 
					{
						for each (var xPos:int in [150, 350])
						{
							(Enemy.pool.ItemFromPool as Enemy).startupBasicEnemy(
								ResourceManager.SmallGreenPlaneGraphics,
								new Point(xPos, -ResourceManager.SmallGreenPlaneGraphics.bitmap.height),
								55);
						}
					}
				));
			LevelDefinitions.Instance.addLevelDefinition(
				2, 
				new LevelDefinitionElement(
					5,
					function():void {(Enemy.pool.ItemFromPool as Enemy).startupBasicEnemy(
						ResourceManager.SmallGreenPlaneGraphics,
						new Point(500, -ResourceManager.SmallGreenPlaneGraphics.bitmap.height),
						55);}));
		}
	}
}