package ui {
	import dis.AScaleBitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class APanel extends Sprite {
		
		public function APanel($width:int, $height:int) {
			super();
			width = $width;
			height = $height;
			createChildren();
		}
		
		
		protected function createChildren():void {
			var bmp:AScaleBitmap = new AScaleBitmap("init", "bmp");
			addChild(bmp);
			bmp.width = this.width;
			bmp.height = this.height;
		}
		
	}

}