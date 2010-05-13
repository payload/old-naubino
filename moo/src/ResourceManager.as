package 
{
	import flash.display.*;
	import flash.geom.*;
	import mx.core.*;
	
	public final class ResourceManager
	{
		[Embed(source="../media/Green22.png")]
		public static var GreenID1:Class;
		public static var GreenGraphicsID1:GraphicsResource = new GraphicsResource(new GreenID1());
		
		[Embed(source="../media/Green19.png")]
		public static var GreenID2:Class;
		public static var GreenGraphicsID2:GraphicsResource = new GraphicsResource(new GreenID2());
		
		[Embed(source="../media/Green20.png")]
		public static var GreenID3:Class;
		public static var GreenGraphicsID3:GraphicsResource = new GraphicsResource(new GreenID3());
		
		[Embed(source="../media/Green21.png")]
		public static var GreenID4:Class;
		public static var GreenGraphicsID4:GraphicsResource = new GraphicsResource(new GreenID4());
		
		[Embed(source="../media/Green23.png")]
		public static var GreenID5:Class;
		public static var GreenGraphicsID5:GraphicsResource = new GraphicsResource(new GreenID5());
		
		[Embed(source="../media/Green24.png")]
		public static var GreenID6:Class;
		public static var GreenGraphicsID6:GraphicsResource = new GraphicsResource(new GreenID6());
		
		[Embed(source="../media/Green28.png")]
		public static var GreenID8:Class;
		public static var GreenGraphicsID8:GraphicsResource = new GraphicsResource(new GreenID8());
		
		[Embed(source="../media/Green29.png")]
		public static var GreenID9:Class;
		public static var GreenGraphicsID9:GraphicsResource = new GraphicsResource(new GreenID9());
		
		[Embed(source="../media/Green30.png")]
		public static var GreenID10:Class;
		public static var GreenGraphicsID10:GraphicsResource = new GraphicsResource(new GreenID10());
		
		[Embed(source="../media/Green3.png")]
		public static var GreenID25:Class;
		public static var GreenGraphicsID25:GraphicsResource = new GraphicsResource(new GreenID25());
		
		[Embed(source="../media/Green26.png")]
		public static var GreenID65:Class;
		public static var GreenGraphicsID65:GraphicsResource = new GraphicsResource(new GreenID65());
		
		[Embed(source="../media/Green25.png")]
		public static var GreenID7:Class;
		public static var GreenGraphicsID7:GraphicsResource = new GraphicsResource(new GreenID7(), 1, 1, new Rectangle(0, 0, 40, 40));
		
		[Embed(source="../media/Green5.png")]
		public static var GreenID11:Class;
		public static var GreenGraphicsID11:GraphicsResource = new GraphicsResource(new GreenID11(), 1, 1, new Rectangle(0, 0, 40, 40));
		public static var GreenGraphicsID12:GraphicsResource = new GraphicsResource(new GreenID11(), 1, 1, new Rectangle(40, 0, 40, 40));
		public static var GreenGraphicsID17:GraphicsResource = new GraphicsResource(new GreenID11(), 1, 1, new Rectangle(0, 40, 40, 40));
		public static var GreenGraphicsID18:GraphicsResource = new GraphicsResource(new GreenID11(), 1, 1, new Rectangle(40, 40, 40, 40));
		
		[Embed(source="../media/Green6.png")]
		public static var GreenID13:Class;
		public static var GreenGraphicsID13:GraphicsResource = new GraphicsResource(new GreenID13(), 1, 1, new Rectangle(0, 0, 40, 40));
		public static var GreenGraphicsID19:GraphicsResource = new GraphicsResource(new GreenID13(), 1, 1, new Rectangle(0, 40, 40, 40));
		
		[Embed(source="../media/Green7.png")]
		public static var GreenID14:Class;
		public static var GreenGraphicsID14:GraphicsResource = new GraphicsResource(new GreenID14(), 1, 1, new Rectangle(0, 0, 40, 40));
		public static var GreenGraphicsID20:GraphicsResource = new GraphicsResource(new GreenID14(), 1, 1, new Rectangle(0, 40, 40, 40));
		
		[Embed(source="../media/Green8.png")]
		public static var GreenID15:Class;
		public static var GreenGraphicsID15:GraphicsResource = new GraphicsResource(new GreenID15(), 1, 1, new Rectangle(0, 0, 40, 40));
		public static var GreenGraphicsID16:GraphicsResource = new GraphicsResource(new GreenID15(), 1, 1, new Rectangle(40, 0, 40, 40));
		public static var GreenGraphicsID21:GraphicsResource = new GraphicsResource(new GreenID15(), 1, 1, new Rectangle(0, 40, 40, 40));
		public static var GreenGraphicsID22:GraphicsResource = new GraphicsResource(new GreenID15(), 1, 1, new Rectangle(40, 40, 40, 40));

		[Embed(source="../media/Green17.png")]
		public static var GreenID23:Class;
		public static var GreenGraphicsID23:GraphicsResource = new GraphicsResource(new GreenID23(), 1, 1, new Rectangle(0, 0, 40, 40));
		public static var GreenGraphicsID24:GraphicsResource = new GraphicsResource(new GreenID23(), 1, 1, new Rectangle(40, 0, 40, 40));
		
		[Embed(source="../media/Green11.png")]
		public static var GreenID26:Class;
		public static var GreenGraphicsID26:GraphicsResource = new GraphicsResource(new GreenID26(), 1, 1, new Rectangle(0, 0, 40, 40));
		public static var GreenGraphicsID27:GraphicsResource = new GraphicsResource(new GreenID26(), 1, 1, new Rectangle(40, 0, 40, 40));
		
		[Embed(source="../media/Green18.png")]
		public static var GreenID28:Class;
		public static var GreenGraphicsID28:GraphicsResource = new GraphicsResource(new GreenID28(), 1, 1, new Rectangle(0, 0, 40, 40));
		public static var GreenGraphicsID29:GraphicsResource = new GraphicsResource(new GreenID28(), 1, 1, new Rectangle(40, 0, 40, 40));
		
		[Embed(source="../media/Green12.png")]
		public static var GreenID30:Class;
		public static var GreenGraphicsID30:GraphicsResource = new GraphicsResource(new GreenID30(), 1, 1, new Rectangle(0, 0, 40, 40));
		public static var GreenGraphicsID31:GraphicsResource = new GraphicsResource(new GreenID30(), 1, 1, new Rectangle(40, 0, 40, 40));
		
		[Embed(source="../media/Green34.png")]
		public static var GreenID32:Class;
		public static var GreenGraphicsID32:GraphicsResource = new GraphicsResource(new GreenID32(), 1, 1, new Rectangle(0, 0, 40, 40));
		public static var GreenGraphicsID33:GraphicsResource = new GraphicsResource(new GreenID32(), 1, 1, new Rectangle(40, 0, 40, 40));
		
		[Embed(source="../media/Green16.png")]
		public static var GreenID34:Class;
		public static var GreenGraphicsID34:GraphicsResource = new GraphicsResource(new GreenID34(), 1, 1, new Rectangle(0, 0, 40, 40));
		public static var GreenGraphicsID35:GraphicsResource = new GraphicsResource(new GreenID34(), 1, 1, new Rectangle(40, 0, 40, 40));
		
		[Embed(source="../media/Green15.png")]
		public static var GreenID36:Class;
		public static var GreenGraphicsID36:GraphicsResource = new GraphicsResource(new GreenID36(), 1, 1, new Rectangle(0, 0, 40, 40));
		public static var GreenGraphicsID44:GraphicsResource = new GraphicsResource(new GreenID36(), 1, 1, new Rectangle(0, 40, 40, 40));
		public static var GreenGraphicsID52:GraphicsResource = new GraphicsResource(new GreenID36(), 1, 1, new Rectangle(0, 80, 40, 40));
		
		[Embed(source="../media/Green14.png")]
		public static var GreenID37:Class;
		public static var GreenGraphicsID37:GraphicsResource = new GraphicsResource(new GreenID37(), 1, 1, new Rectangle(0, 0, 40, 40));
		public static var GreenGraphicsID45:GraphicsResource = new GraphicsResource(new GreenID37(), 1, 1, new Rectangle(0, 40, 40, 40));
		public static var GreenGraphicsID53:GraphicsResource = new GraphicsResource(new GreenID37(), 1, 1, new Rectangle(0, 80, 40, 40));
		
		[Embed(source="../media/Green13.png")]
		public static var GreenID38:Class;
		public static var GreenGraphicsID38:GraphicsResource = new GraphicsResource(new GreenID38(), 1, 1, new Rectangle(0, 0, 40, 40));
		public static var GreenGraphicsID46:GraphicsResource = new GraphicsResource(new GreenID38(), 1, 1, new Rectangle(0, 40, 40, 40));
		public static var GreenGraphicsID47:GraphicsResource = new GraphicsResource(new GreenID38(), 1, 1, new Rectangle(40, 40, 40, 40));
		public static var GreenGraphicsID54:GraphicsResource = new GraphicsResource(new GreenID38(), 1, 1, new Rectangle(0, 80, 40, 40));
		public static var GreenGraphicsID55:GraphicsResource = new GraphicsResource(new GreenID38(), 1, 1, new Rectangle(40, 80, 40, 40));
		public static var GreenGraphicsID39:GraphicsResource = new GraphicsResource(new GreenID38(), 1, 1, new Rectangle(40, 0, 40, 40));
		
		[Embed(source="../media/Green34.png")]
		public static var GreenID40:Class;
		public static var GreenGraphicsID40:GraphicsResource = new GraphicsResource(new GreenID40(), 1, 1, new Rectangle(0, 40, 40, 40));
		public static var GreenGraphicsID41:GraphicsResource = new GraphicsResource(new GreenID40(), 1, 1, new Rectangle(40, 40, 40, 40));
		
		[Embed(source="../media/Green16.png")]
		public static var GreenID42:Class;
		public static var GreenGraphicsID42:GraphicsResource = new GraphicsResource(new GreenID42(), 1, 1, new Rectangle(0, 40, 40, 40));
		public static var GreenGraphicsID43:GraphicsResource = new GraphicsResource(new GreenID42(), 1, 1, new Rectangle(40, 40, 40, 40));
		public static var GreenGraphicsID50:GraphicsResource = new GraphicsResource(new GreenID42(), 1, 1, new Rectangle(0, 80, 40, 40));
		public static var GreenGraphicsID51:GraphicsResource = new GraphicsResource(new GreenID42(), 1, 1, new Rectangle(40, 80, 40, 40));
		
		[Embed(source="../media/Green34.png")]
		public static var GreenID48:Class;
		public static var GreenGraphicsID48:GraphicsResource = new GraphicsResource(new GreenID48(), 1, 1, new Rectangle(0, 80, 40, 40));
		public static var GreenGraphicsID49:GraphicsResource = new GraphicsResource(new GreenID48(), 1, 1, new Rectangle(40, 80, 40, 40));
		
		[Embed(source="../media/Green33.png")]
		public static var GreenID56:Class;
		public static var GreenGraphicsID56:GraphicsResource = new GraphicsResource(new GreenID56(), 1, 1, new Rectangle(0, 0, 40, 40));
		public static var GreenGraphicsID57:GraphicsResource = new GraphicsResource(new GreenID56(), 1, 1, new Rectangle(40, 0, 40, 40));
		public static var GreenGraphicsID58:GraphicsResource = new GraphicsResource(new GreenID56(), 1, 1, new Rectangle(80, 0, 40, 40));
		public static var GreenGraphicsID59:GraphicsResource = new GraphicsResource(new GreenID56(), 1, 1, new Rectangle(0, 40, 40, 40));
		public static var GreenGraphicsID60:GraphicsResource = new GraphicsResource(new GreenID56(), 1, 1, new Rectangle(40, 40, 40, 40));
		public static var GreenGraphicsID61:GraphicsResource = new GraphicsResource(new GreenID56(), 1, 1, new Rectangle(80, 40, 40, 40));
		public static var GreenGraphicsID62:GraphicsResource = new GraphicsResource(new GreenID56(), 1, 1, new Rectangle(0, 80, 40, 40));
		public static var GreenGraphicsID63:GraphicsResource = new GraphicsResource(new GreenID56(), 1, 1, new Rectangle(40, 80, 40, 40));
		public static var GreenGraphicsID64:GraphicsResource = new GraphicsResource(new GreenID56(), 1, 1, new Rectangle(80, 80, 40, 40));

		[Embed(source="../media/brownplane.png")]
		public static var BrownPlane:Class;
		public static var BrownPlaneGraphics:GraphicsResource = new GraphicsResource(new BrownPlane(), 3, 20);
		
		[Embed(source="../media/smallgreenplane.png")]
		public static var SmallGreenPlane:Class;
		public static var SmallGreenPlaneGraphics:GraphicsResource = new GraphicsResource(new SmallGreenPlane(), 3, 20);
		
		[Embed(source="../media/smallblueplane.png")]
		public static var SmallBluePlane:Class;
		public static var SmallBluePlaneGraphics:GraphicsResource = new GraphicsResource(new SmallBluePlane(), 3, 20);
		
		[Embed(source="../media/smallwhiteplane.png")]
		public static var SmallWhitePlane:Class;
		public static var SmallWhitePlaneGraphics:GraphicsResource = new GraphicsResource(new SmallWhitePlane(), 3, 20);
		
		[Embed(source="../media/bigexplosion.png")]
		public static var BigExplosion:Class;
		public static var BigExplosionGraphics:GraphicsResource = new GraphicsResource(new BigExplosion(), 7, 20);
		
		[Embed(source="../media/smallisland.png")]
		public static var SmallIsland:Class;
		public static var SmallIslandGraphics:GraphicsResource = new GraphicsResource(new SmallIsland());
		
		[Embed(source="../media/bigisland.png")]
		public static var BigIsland:Class;
		public static var BigIslandGraphics:GraphicsResource = new GraphicsResource(new BigIsland());
		
		[Embed(source="../media/volcanoisland.png")]
		public static var VolcanoIsland:Class;
		public static var VolcanoIslandGraphics:GraphicsResource = new GraphicsResource(new VolcanoIsland());
		
		[Embed(source="../media/twobullets.png")]
		public static var TwoBullets:Class;
		public static var TwoBulletsGraphics:GraphicsResource = new GraphicsResource(new TwoBullets());
		
		[Embed(source="../media/cloud.png")]
		public static var Cloud:Class;
		public static var CloudGraphics:GraphicsResource = new GraphicsResource(new Cloud());
		
		[Embed(source="../media/gun1.mp3")]
		public static var Gun1Sound:Class;
		public static var Gun1FX:SoundAsset = new Gun1Sound() as SoundAsset;	
		
		[Embed(source="../media/explosion.mp3")]
		public static var ExplosionSound:Class;
		public static var ExplosionFX:SoundAsset = new ExplosionSound() as SoundAsset;	
		
		[Embed(source="../media/track1.mp3")]
		public static var Track1Sound:Class;
		public static var Track1FX:SoundAsset = new Track1Sound() as SoundAsset;	
	}
}