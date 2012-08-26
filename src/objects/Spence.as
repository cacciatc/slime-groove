package objects 
{
	import com.greensock.easing.Back;
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import flash.geom.Point;

	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import org.flashdevelop.utils.FlashConnect;
	
	public class Spence extends Entity 
	{
		[Embed(source = '../assets/graphics/spence.png')] public static const SPENCE:Class;
		public static const TILE_SIZE:int = 160;
		public static const MAX_SPEED:Number = 3;
		public static const ACCEL:Number = 1;
		public static const FRICTION:Number = MAX_SPEED / (MAX_SPEED + ACCEL);
		public static const MIN_SPEED:Number = ACCEL * FRICTION;
		
		public var sprite:Spritemap = new Spritemap(SPENCE, TILE_SIZE, TILE_SIZE);
		public var speed:Point = new Point();
		public var safeSpot:Point;
		
		public var onStairs:Boolean;
		public var destDoor:Door;
		
		public function Spence(x:int, y:int) 
		{
			super(x, y, sprite);
			setHitbox(TILE_SIZE-40, TILE_SIZE-30);
			
			sprite.add("Idle", [0], 0, false);
			sprite.add("Run", [1, 2, 3], 10, true);
			sprite.add("Shoot", [4, 5, 6, 7, 8], 10, false);
			
			safeSpot = new Point(x, y);
			
			name = "Spence";
			
			onStairs = false;
		}
		
		override public function update():void 
		{
			if (onStairs)
			{
				
			}
			else {
				if (Input.check(Key.RIGHT))
					speed.x += ACCEL;
				
				if (Input.check(Key.LEFT))
					speed.x -= ACCEL;
				
				speed.x *= FRICTION;
				
				if (Math.abs(speed.x) < MIN_SPEED)
					speed.x = 0;
				
				moveBy(speed.x, speed.y, "Solid", true);
				
				x = Math.max(x, 2);
				
				if (Math.abs(speed.x) > 0.1 && sprite.currentAnim != "Shoot")
				{
					sprite.play("Run");
					sprite.rate = FP.scale(Math.abs(speed.x), 0, MAX_SPEED, 0, 1);
				}
				else
				{
					if (Input.released(Key.SPACE))
					{
						sprite.play("Shoot");
						sprite.rate = 1;
							
						if (sprite.flipped)
						{
							FP.world.add(new Bullet(x - 70, y+20, -5));
						}
						else
						{
							FP.world.add(new Bullet(x + 70, y+20, 5));
						}
					}
					else if(sprite.currentAnim != "Shoot"){
						sprite.play("Idle");
						sprite.rate = 1;
					}
				}
			}
				
			var door:Door = Door(collide("Door", x, y));
			if (door)
			{
				if (Input.check(Key.UP))
				{
					if (door.isOpened())
					{
						onStairs = true;
						doorTime(door);
					}
					else
					{
						door.open();
					}
				}
				else if (Input.check(Key.DOWN))
				{
					door.close();
				}
			}
				
			if (speed.x != 0)
				sprite.flipped = speed.x < 0; 
				
			if (sprite.complete && sprite.currentAnim == "Shoot")
			{
				sprite.play("Idle");	
			}
				/*if (collide("Death", x, y))
				{
					//world.add(new Explode(x, y - 10));
					speed.x = speed.y = 0;
					active = false;
					sprite.alpha = 0.5;
					TweenMax.to(this, 0.5, { x:safeSpot.x, y:safeSpot.y, ease:Back.easeIn, onComplete:enable } );
					Room(world).shake(20, 4);
				}
				else if (!collide("Death", x + 20, y) && !collide("Death", x - 20, y))
				{
					if (collide("Solid", x, y + 1) && collide("Solid", x + 20, y + 1) && collide("Solid", x - 20, y + 1))
					{
						safeSpot.x = x;
						safeSpot.y = y;
					}
				}*/
		}
		
		public function dismount():void
		{
			sprite.visible = true;
			onStairs = false;
			destDoor.close();
		}
		
		public function updateStairs():void
		{
			destDoor.open();
			TweenMax.to(this, 0.1, { delay:0.5, onComplete: dismount} );
		}
		
		public function doorTime(door:Door):void
		{
			sprite.visible = false;
			
			door.close();
			
			var doors:Array = new Array();
			FP.world.getType("Door", doors);
			
			for each(var d:Door in doors)
			{
				if (d.doorName == door.dest)
				{
					destDoor = d;
					TweenMax.killTweensOf(this);
					TweenMax.to(this, 1, { x:d.x + 3, y:d.y, delay:0.5, onComplete:updateStairs } );
					break;
				}
			}
		}
		
		public function enable():void
		{
			sprite.alpha = 1;
			active = true;
		}
		
		override public function moveCollideX(e:Entity):Boolean 
		{
			speed.x = 0;
			return true;
		}
		
		public function squish(x:Number, y:Number):void
		{
			sprite.scaleX = x;
			sprite.scaleY = y;
			TweenMax.killTweensOf(sprite);
			TweenMax.to(sprite, 0.15, { scaleX:1, scaleY:1, ease:Cubic.easeIn } );
		}
	}
}