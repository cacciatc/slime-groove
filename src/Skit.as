package  
{
	import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import com.greensock.TweenMax;
	import objects.Sandy;
	import objects.Spence;
	import punk.ui.PunkLabel;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Chris Cacciatore
	 */
	public class Skit 
	{
		public var spence:Spence;
		public var sandy:Sandy;
		public var over:Boolean;
		public var label:PunkLabel;
		
		public function Skit(thespence:Spence, thesandy:Sandy, t:PunkLabel) 
		{
			spence = thespence;
			sandy = thesandy;
			over = false;
			label = t;
			
			TweenMax.to(sandy, 0.5, { x:spence.x + 100 , onComplete: startTalk,delay:2} );
		}
		
		public function startTalk():void
		{
			sandy.standstill();
			TweenMax.to(sandy, 0.4, { y:150, repeat: 3, onComplete:a} );

		}
		
		public function a():void
		{
			sandy.y = 160;
			label.text = "SANDY:  SPENCE! YOUR SLIMES--YOUR EXPERIMENTS!";
			FP.alarm(4, b);
			FP.alarm(8, g);
			FP.alarm(12, c);
			FP.alarm(16, d);
		}
		
		public function g():void
		{
			label.text = "SANDY: THEY'RE EVOLVING TOO FAST!!!";
		}
		
		public function b():void
		{
			label.text = "SANDY: THEY STARTED BREEDING!  GROWING LARGER & AGGRESSIVE.";
		}
		
		public function c():void
		{
			label.text = "SANDY: YOU HAVE TO DESTROY THEM BEFORE THEY EVOLVE FURTHER.";
		}
		
		public function e():void
		{
			label.text = "<HANDS SPENCE GUN>  GOOD LUCK!";
		}
		
		public function d():void
		{
			label.text = "SANDY: HERE I FOUND THIS!  HIT SPACE TO FIRE";
			FP.alarm(3, e);
			TweenMax.to(sandy, 1, { x:0 , onComplete:stairsRemind, delay:4} );
		}
		
		public function stairsRemind():void
		{
			TweenMax.to(sandy, 0.5, { x:600, onComplete:w } );
			TweenMax.to(sandy, 1, { x:0 , onComplete:destroySandy, delay:4} );

			FP.alarm(4, k);
		}
		
		public function w():void
		{
			
			label.text = "SANDY:  OH, AND UP/DOWN KEYS OPEN/CLOSE/ENTER DOORS."
		}
		
		public function k():void
		{
			label.text = "";
		}
		
		public function destroySandy():void
		{
			over = true;
			FP.volume = 1;
			FP.world.remove(sandy);
			spence.toggleCement();
		}
		
	}

}