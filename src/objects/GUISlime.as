package objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Chris Cacciatore
	 */
	public class GUISlime extends Entity 
	{
		[Embed(source = "../assets/graphics/powerups.png")] public static const SLIME:Class;
		
		public var sprite:Spritemap = new Spritemap(SLIME, 80,80);
		public function GUISlime(x:int,y:int) 
		{
			super(x, y, sprite);
			sprite.add("Jumping", [6, 7, 8, 9, 10, 9, 8, ], 5, true);
			sprite.play("Jumping");
		}
		
	}

}