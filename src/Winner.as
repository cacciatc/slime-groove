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
	public class Winner extends Room 
	{
		
		public function Winner() 
		{
			var a:PunkLabel = new PunkLabel("CONGRATULATIONS!\n\nYOU'VE CONTAINED YOUR\nNASTY EXPERIMENT!\n\n\nPRESS ANY KEY TO PLAY AGAIN", 320 - 290, 240 - 140);
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