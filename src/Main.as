package 
{
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.display.StageQuality;
	import flash.geom.Rectangle;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	public class Main extends Engine 
	{
		public function Main()
		{
			super(640, 384, 60);
			FP.screen.scale = 8;
			FP.screen.color = 0x444444;
			
			FP.world = new SlimeGroove();
		}
	}
}