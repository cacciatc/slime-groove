package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import objects.Spence;
	import objects.BlueSlime;
	import objects.Door;
	
	import org.flashdevelop.utils.FlashConnect;
	
	public class SlimeGroove extends Room
	{
		[Embed(source = "levels/mini-lab.oel", mimeType = "application/octet-stream")] public static const LAB:Class;
		[Embed(source = "assets/graphics/background-tiles.png")] public static const BACKGROUND:Class;
		[Embed(source = 'assets/graphics/background-textures.png')] public static const WALLS:Class;
		
		
		public var file:Class;
		public var level:XML;
		public var width:int;
		public var height:int;
		public var background:Backdrop;
		public var solids:Grid;
		public var tiles:Tilemap;
		public var back:Tilemap;
		public var spence:Spence;
		
		public function SlimeGroove(file:Class = null) 
		{
			if (file == null)
				file = LAB;
			
			this.file = file;
			level = FP.getXML(file);
			
			width = level.@width;
			height = level.@height;
			
			solids = new Grid(width, height, 16, 16);
			solids.loadFromString(level.Boundry, "", "\n");
			addMask(solids, "Solid");
			
			back = new Tilemap(WALLS, 128, 64, 16, 16);
			back.loadFromString(level.Tiles, ",", "\n");

			addGraphic(back, 20);
			
			tiles = new Tilemap(BACKGROUND, 128, 64, 16, 16);
			tiles.loadFromString(level.Background, ",", "\n");
			
			addGraphic(tiles, 10);

			var o:XML;
			
				
			for each (o in level.Entities.Door)
			{
				add(new Door(int(o.@x), int(o.@y) + 16, int(o.@To), int(o.@name)));
			}
			
			for each (o in level.Entities.Spence)
			{
				add(spence = new Spence(int(o.@x), int(o.@y)+16));
			}
			
			for each (o in level.Entities.BlueSlime)
			{
				add(new BlueSlime(int(o.@x), int(o.@y) + 16));
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			camera.x += (FP.clamp(spence.x - 32, 0, width) - camera.x)
			camera.y = spence.y - 32;
			
			//camera.y += (FP.clamp(spence.y, 0, 16) - camera.y)
			//if (player.x > width + 10)
			//{
			//	trace("Complete!");
			//	active = false;
			//}
		}
	}
}