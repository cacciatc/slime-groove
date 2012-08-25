package objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Chris Cacciatore
	 */
	public class Slime extends Entity 
	{
		public var health:int;
		public var sprite:Spritemap 
		public function Slime(x:int, y:int, thesprite:Spritemap, theHealth:int) 
		{
			health = theHealth;
			sprite = thesprite;
			super(x, y, sprite);
		}
	}

}