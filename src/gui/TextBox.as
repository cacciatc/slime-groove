package gui
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;

	/**
	 * ...
	 * @author Chris Cacciatore
	 */
	public class TextBox extends Entity 
	{
		public var text:Text;
		public function TextBox(x:int, y:int, msg:String) 
		{
			text = new Text(msg);
			text.scale = 0.5;
			super(x, y, text);
			layer = 30;
			type = "Text";
		}

	}

}