package objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Chris Cacciatore
	 */
	public class Sandy extends Entity 
	{
		[Embed(source = "../assets/graphics/sandy.png")] public static const SANDY:Class;
		
		public var sprite:Spritemap = new Spritemap(SANDY, 160,160);
		public function Sandy(x:int,y:int) 
		{
			super(x, y, sprite);
			sprite.add("Idle", [0], 0, false);
			sprite.add("Running", [1, 2, 3, 4], 12, true);
			sprite.play("Running");
		}
	
		public function standstill():void
		{
			
			sprite.play("Idle");
		}
	}

}