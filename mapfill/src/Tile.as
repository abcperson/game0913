package  {
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class Tile extends Sprite {
		
		public var size:int;
		public var setID:int;
		
		public function Tile($size:int, $setID:int) {
			size = $size;
			setID = $setID;
			
			if (setID > 0) {				
				graphics.lineStyle(1, 0xFF0000);
			}else {
				graphics.lineStyle(1);
			}
			graphics.moveTo(0, 0);
			graphics.lineTo(size, size / 2);
			graphics.lineTo(0, size);
			graphics.lineTo( -size, size / 2);
			graphics.lineTo(0, 0);
			graphics.lineStyle();
		}
		
	}

}