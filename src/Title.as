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
	public class Title extends Room 
	{
		public var d:PunkLabel;
		public function Title() 
		{
			var a:PunkLabel = new PunkLabel("SLIME GROOVE", 320 - 50, 240 - 140);
			a.size = 32;
			add(a);
			d= new PunkLabel("HIT ANY KEY", 320 - 15, 240 - 100);
			d.size = 23;
			add(d);
			add(new GUISpence(100, 100));
			
			add(new PunkLabel("Made by: Chris Cacciatore (@cacciatc) for LD #24",117, 300));
		}
		
		override public function update():void
		{
			super.update();
			if (Input.check(Key.ANY))
			{
				FP.alarm(0.3, a);
				FP.alarm(0.6, b);
				FP.alarm(0.9, a);
				FP.alarm(1.2, b);
				FP.alarm(1.2, c);
			}
		}
		
		public function a():void
		{
			d.visible = false;
		}
		
		public function b():void
		{
			
			d.visible = true;
		}
		
		public function c():void
		{
			FP.world = new SlimeGroove();
		}
		
	}

}