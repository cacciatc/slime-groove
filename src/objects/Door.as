package objects 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	
	import org.flashdevelop.utils.FlashConnect;
	
	public class Door extends Entity 
	{
		[Embed(source = "../assets/graphics/background-tiles.png")] public static const DOOR:Class;
		[Embed(source = "../assets/audio/door-close.mp3")] public static const CLOSE:Class;
		
		public var sprite:Spritemap = new Spritemap(DOOR, 160, 160);
		public var closeSnd:Sfx = new Sfx(CLOSE);
		
		public var dest:int;
		public var doorName:int;
		
		public function Door(x:int, y:int, to:int, newName:int) 
		{
			super(x, y, sprite);
			setHitbox(160-40, 160-30, 40, 30);

			sprite.add("Closed", [8], 0, false);
			sprite.add("Opening", [9, 10, 11], 5, false);
			sprite.add("Opened", [11], 0, false);
			sprite.add("Closing", [11, 10, 9], 5, false);
			
			sprite.play("Closed");
			
			dest = to;
			doorName = newName;
			
			type = "Door";
		}
		
		public function open():void 
		{
			if (sprite.currentAnim == "Closed")
			{
				sprite.play("Opening");
			}
		}
		
		public function close():void 
		{
			sprite.play("Closing");
		}
		
		public function isOpened():Boolean 
		{
			return sprite.currentAnim == "Opened";
		}
		
		override public function update():void 
		{
			if (sprite.complete)
			{
				if (sprite.currentAnim == "Opening")
				{
					sprite.play("Opened");
				}
				else if (sprite.currentAnim == "Closing")
				{
					sprite.play("Closed");
					if (!closeSnd.playing)
					{
						closeSnd.play(0.02);
					}
				}
			}
		}
		
	}
}