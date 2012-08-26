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
	import objects.GUIClock;
	import objects.GUISlime;
	import objects.Spence;
	import objects.BlueSlime;
	import objects.Door;
	import objects.Stats;
	import objects.YellowSlime;
	import punk.ui.PunkLabel;
	import Winner;
	import objects.Sandy;
	
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
		public var sandy:Sandy;
		
		public var slimesLeft:PunkLabel;
		public var timeLeft:PunkLabel;
		public var stats:Stats;
		public var timeTimer:Number = 0.0;
		
		public var guiSlime:GUISlime;
		public var guiClock:GUIClock;
		
		public var skit:Skit;
		
		public static const TILE_SIZE:int = 160;
		
		public function SlimeGroove(file:Class = null) 
		{
			this.visible = false;
			
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
				add(new Door(int(o.@x), int(o.@y) + 0, int(o.@to), int(o.@name)));
			}
			
			for each (o in level.Entities.Spence)
			{
				add(spence = new Spence(int(o.@x), int(o.@y)+0));
			}
			
			for each (o in level.Entities.Sandy)
			{
				add(sandy = new Sandy(int(o.@x), int(o.@y)+0));
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
			
			stats = new Stats();
			stats.slimeTotal = count;
			stats.slimeCount = 0;
			stats.slimeTime = 200;
			
			guiSlime = new GUISlime(0, 0);
			add(guiSlime);
			
			guiClock = new GUIClock(0, 0);
			add(guiClock);
			
			slimesLeft = new PunkLabel("x" + (stats.slimeTotal - stats.slimeCount),0, 0);
			slimesLeft.size = 32;
			
			timeLeft = new PunkLabel(String(stats.slimeTime), spence.x+60, 10);
			timeLeft.size = 32;
			
			add(slimesLeft);
			add(timeLeft);
			add(stats);
			
			var l:PunkLabel = new PunkLabel("", spence.x -310 + 5, spence.y - 30);
			l.size = 18;
			skit = new Skit(spence, sandy, l);
			
			add(l);
			
			FP.volume = 0;
		}
		
		override public function update():void 
		{
			super.update();
			
			camera.x += (FP.clamp(spence.x - 320, -10, width) - camera.x)
			camera.y = spence.y - 160;
			
			slimesLeft.x = Math.max(75, spence.x - 310+75);
			slimesLeft.y = spence.y -135;
			
			guiSlime.x = Math.max(0, spence.x -310);
			guiSlime.y = spence.y -185;
			
			timeLeft.x = Math.max(335, spence.x +25);
			timeLeft.y = spence.y -135;
			
			guiClock.x = Math.max(260, spence.x - 50);
			guiClock.y = spence.y -175;

			slimesLeft.text = "x" + (stats.slimeTotal - stats.slimeCount)
			
			timeTimer += FP.elapsed;
			
			if (stats.slimeTotal - stats.slimeCount == 0)
			{
				FP.world new Winner();
				
			}

			if(timeTimer > 1.0 && skit.over)
			{
				var s:Stats = FP.world.getInstance("Stats");
				s.slimeTime -=  1;
				timeLeft.text = String(s.slimeTime);
				timeTimer = 0;
				if (s.slimeTime <= 0) {
					FP.world = new GameOver();
				}
			}
			if (!visible) {
				visible = true;
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