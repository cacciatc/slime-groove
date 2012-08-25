package objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.FP;
	import com.greensock.TweenMax;
	
	public class YellowSlime extends Slime 
	{
		[Embed(source = "../assets/graphics/slimes_sm.png")] public static const SLIME:Class;
		[Embed(source = "../assets/audio/slime-jump.mp3")] public static const JUMP:Class;
		
		public var jumpSnd:Sfx = new Sfx(JUMP);
		
		public function YellowSlime(x:int, y:int) 
		{
			super(x, y, new Spritemap(SLIME, 16, 16), 5);
			setHitbox(8, 10, 4, 10);
			sprite.originX = 8;
			sprite.originY = 16;
			
			sprite.add("Idle", [0], 0, false);
			sprite.add("Jumping", [1, 2, 3, 4, 3], 5, false);
			
			sprite.play("Idle");
			
			type = "Slime";
		}
		
		override public function update():void 
		{
			jump();
			if (sprite.complete)
				sprite.play("Idle");
				
			if (collide("Solid", x, y - 10))
			{
				TweenMax.killTweensOf(this);
			}
		}
		
		private function jump():void 
		{
			if(sprite.currentAnim != "Jumping"){
				sprite.play("Jumping");
				if (!jumpSnd.playing && FP.world.getInstance("Spence").y == y)
				{
					if (FP.world.getInstance("Spence").x > x)
					{
						jumpSnd.pan = 1;
						jumpSnd.play(0.02);
					}
					else 
					{
						jumpSnd.pan = -1;
						jumpSnd.play(0.02);
						
					}
				}
			}
		}
	}
}