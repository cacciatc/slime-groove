package objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import com.greensock.TweenMax;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	import org.flashdevelop.utils.FlashConnect;
	import objects.BlueSlime;
	
	/**
	 * ...
	 * @author Chris Cacciatore
	 */
	public class Bullet extends Entity 
	{
		[Embed(source = "../assets/graphics/special-effects.png")] public const BULLET:Class;
		
		public var sprite:Spritemap = new Spritemap(BULLET, 160, 160);
		public var dx:Number;
		
		public function Bullet(x:int, y:int, thedx:Number) 
		{
			super(x, y, sprite);
			setHitbox(160-130, 160-30);
			
			sprite.add("Flying", [0, 1, 2], 30, true);
			sprite.add("Dying", [3, 4, 5], 10, false);
			
			sprite.play("Flying");
			
			type = "Death";
			dx = thedx;
		}
		
		override public function update():void
		{
			var slime:BlueSlime;
			if (collide("Solid",x,y))
			{
				//FP.world.remove(this);
			}
			if ((slime = BlueSlime(collide("BlueSlime", x, y))))
			{
				if (slime.health > 0)
				{
					slime.health -= 1;
					if (dx < 0)
					{
						TweenMax.to(slime, 1, { x:slime.x - 60, y:slime.y} );
					}
					else
					{
						TweenMax.to(slime, 1, { x:slime.x + 60, y:slime.y} );
					}
					FP.world.remove(this);
				}
				else
				{
					y -= 20;
					FP.world.remove(slime);
					sprite.play("Dying");
					var s:Stats = FP.world.getInstance("Stats");
					s.slimeCount += 1;
				}
				
			}
			if (sprite.currentAnim == "Dying" && sprite.complete)
			{
				FP.world.remove(this);
			}
			x += dx;
		}
		
	}

}