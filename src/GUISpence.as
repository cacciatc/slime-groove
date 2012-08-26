package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import com.greensock.TweenMax;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Chris Cacciatore
	 */
	public class GUISpence extends Entity 
	{
		[Embed(source = "assets/graphics/title.png")] public static const SPENCE:Class;
		
		public var sprite:Spritemap = new Spritemap(SPENCE, 160,160);
		public function GUISpence(x:int,y:int) 
		{
			super(x, y, sprite);
			sprite.add("Idle",[0],0,false);
			sprite.add("Blinking", [0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0], 5, true);
			sprite.play("Blinking");
		}
		
		override public function update():void
		{
			if (sprite.complete)
			{
				Math.random() > 0.7 ? sprite.play("Idle") : sprite.play("Blinking");
			}
			
			
		}
	}

}