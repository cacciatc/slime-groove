package objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import com.greensock.TweenMax;
	
	/**
	 * ...
	 * @author Chris Cacciatore
	 */
	public class Bullet extends Entity 
	{
		[Embed(source = "../assets/graphics/special-effects.png")] public const BULLET:Class;
		
		public var sprite:Spritemap = new Spritemap(BULLET, 16, 16);
		public var dx:Number;
		
		public function Bullet(x:int, y:int, thedx:Number) 
		{
			super(x, y, sprite);
			setHitbox(2, 4, 4, 4);
			sprite.originX = 8;
			sprite.originY = 16;
			
			sprite.add("Flying", [0, 1, 2], 30, true);
			sprite.add("Dying", [3, 4, 5], 10, false);
			
			sprite.play("Flying");
			
			type = "Death";
			dx = thedx;
		}
		
		override public function update():void
		{
			var slime:Slime;
			if (collide("Solid",x,y-8))
			{
				FP.world.remove(this);
			}
			if ((slime = Slime(collide("Slime", x, y))))
			{
				if (slime.health > 0)
				{
					FP.world.remove(this);
					slime.health -= 1;
					TweenMax.to(slime, 1, { x:(slime.x + (dx/4)) } );
				}
				else
				{
					y -= 1;
					FP.world.remove(slime);
					sprite.play("Dying");
					var s:Stats = FP.world.getInstance("Stat");
					s.slimeCount -= 1;
				}
				
			}
			if (sprite.currentAnim == "Dying" && sprite.complete)
			{
				FP.world.remove(this);
			}
			x += dx*FP.elapsed;
		}
		
	}

}