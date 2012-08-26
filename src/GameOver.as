package  
{
	import punk.ui.PunkLabel;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Chris Cacciatore
	 */
	public class GameOver extends Room 
	{
		
		public function GameOver() 
		{
			var a:PunkLabel = new PunkLabel("TIME'S UP!\n\nPRESS ANY BUTTON\n\nTO TRY AGAIN", 320 - 160, 240 - 140);
			a.size = 32;
			add(a);
		}
		
		override public function update():void
		{
			if (Input.check(Key.ANY))
			{
				FP.world = new SlimeGroove();
			}
		}
		
	}

}