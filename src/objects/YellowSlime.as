package objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.FP;
	import com.greensock.TweenMax;
	
	public class YellowSlime extends Entity 
	{
		[Embed(source = "../assets/graphics/slimes_sm.png")] public static const SLIME:Class;
		[Embed(source = "../assets/audio/slime-jump.mp3")] public static const JUMP:Class;
		
		public var sprite:Spritemap = new Spritemap(SLIME, 160,160);
		public var jumpSnd:Sfx = new Sfx(JUMP);
		public var health:int = 2;
		
		public function YellowSlime(x:int, y:int) 
		{
			super(x, y, sprite);
			setHitbox(160, 160 - 30);
			
			sprite.add("Idle", [5], 0, false);
			sprite.add("Jumping", [6, 7, 8, 9, 8], 5, false);
		
			sprite.play("Idle");
			type = "Slime";
		}
		
		override public function update():void 
		{
			jump();
			if (sprite.complete)
				sprite.play("Idle");
				
			//if (collide("Solid", x, y - 10))
			//{
			//	TweenMax.killTweensOf(this);
			//}
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