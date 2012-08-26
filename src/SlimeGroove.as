package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import objects.Spence;
	import objects.BlueSlime;
	import objects.Door;
	import objects.Stats;
	import objects.YellowSlime;
	import punk.ui.PunkLabel;
	
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
		
		public var slimesLeft:PunkLabel;
		public var timeLeft:PunkLabel;
		
		public var timeTimer:Number = 0.0;
		
		public static const TILE_SIZE:int = 160;
		
		public function SlimeGroove(file:Class = null) 
		{
			if (file == null)
				file = LAB;
			
			this.file = file;
			level = FP.getXML(file);
			
			width = int(level.@width);
			height = int(level.@height);
			
			solids = new Grid(width, height, TILE_SIZE, TILE_SIZE);
			solids.loadFromString(level.Boundry, "", "\n");
			addMask(solids, "Solid");
			
			back = new Tilemap(WALLS, width, height, TILE_SIZE, TILE_SIZE);

			back.loadFromString(level.Tiles, ",", "\n");

			addGraphic(back, 20);
			
			tiles = new Tilemap(BACKGROUND, width, height, TILE_SIZE, TILE_SIZE);

			tiles.loadFromString(level.Background, ",", "\n");
			
			addGraphic(tiles, 10);

			var o:XML;
			
				
			for each (o in level.Entities.Door)
			{
				add(new Door(int(o.@x), int(o.@y) + 0, int(o.@To), int(o.@name)));
			}
			
			for each (o in level.Entities.Spence)
			{
				add(spence = new Spence(int(o.@x), int(o.@y)+0));
			}
			
			var count:int = 0;
			for each (o in level.Entities.BlueSlime)
			{
				count += 1;
				add(new BlueSlime(int(o.@x), int(o.@y)));
			}
			//for each (o in level.Entities.YellowSlime)
			//{
			//	count += 1;
			//	add(new YellowSlime(int(o.@x), int(o.@y) + 0));
			//}
			
			var stats:Stats = new Stats();
			stats.slimeTotal = count;
			stats.slimeCount = 0;
			stats.slimeTime = 30;
			
			slimesLeft = new PunkLabel(stats.slimeCount + "/" + stats.slimeTotal + " slimes left", spence.x+60, 10);
			slimesLeft.size = 32;
			
			timeLeft = new PunkLabel(String(stats.slimeTime) + " sec left", spence.x+60, 10);
			timeLeft.size = 32;
			
			add(slimesLeft);
			add(timeLeft);
			add(stats);
		}
		
		override public function update():void 
		{
			super.update();
			
			camera.x += (FP.clamp(spence.x - 320, -10, width) - camera.x)
			camera.y = spence.y - 160;
			
			slimesLeft.x = spence.x + 60;
			slimesLeft.y = spence.y - 160;
			timeLeft.x = spence.x+128;
			timeLeft.y = spence.y - 160+32;

			slimesLeft.text = FP.world.getInstance("Stats").slimeCount + "/" + FP.world.getInstance("Stats").slimeTotal + " slimes left";
			
			timeTimer += FP.elapsed;

			if(timeTimer > 1.0)
			{
				var s:Stats = FP.world.getInstance("Stats");
				s.slimeTime -=  1;
				timeLeft.text = String(s.slimeTime) + " sec left";
				timeTimer = 0;
			}
			//camera.y += (FP.clamp(spence.y, 0, 16) - camera.y)
			//if (player.x > width + 10)
			//{
			//	trace("Complete!");
			//	active = false;
			//}
		}
	}
}