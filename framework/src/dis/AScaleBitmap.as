package dis {
	import flash.display.Bitmap;
	import res.ResInfo;
	import res.ResManager;
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class AScaleBitmap extends ScaleBitmap {
		
		[Embed(source = "../test/default.jpg")]
		private static var bmpClass:Class;
		
		public function AScaleBitmap($mod:String, $resName:String) {
			var bmp:Bitmap = new bmpClass();
			super(bmp.bitmapData);
			
			ResManager.useRes($mod, $resName, onBmpLoaded);
		}
		
		private function onBmpLoaded($res:ResInfo):void {
			var beforeWidth:int = this.width;
			var beforeHeight:int = this.height;
			this.scaleX  = 1;
			this.scaleY = 1;
			this.bitmapData = $res.bmp.bitmapData;
			this.width = beforeWidth;
			this.height = beforeHeight;
		}
		
	}

}