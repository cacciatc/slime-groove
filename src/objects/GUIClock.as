package objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Chris Cacciatore
	 */
	public class GUIClock extends Entity 
	{
		[Embed(source = "../assets/graphics/powerups.png")] public static const CLOCK:Class;
		
		public var sprite:Spritemap = new Spritemap(CLOCK, 80,80);
		public function GUIClock(x:int,y:int) 
		{
			super(x, y, sprite);
			sprite.add("Ticking", [11, 12, 13, 14, 15, 16], 1, true);
			sprite.play("Ticking");
		}
		
	}

}