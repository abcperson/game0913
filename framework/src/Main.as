package {
	import dis.ScaleBitmap;
	import fl.controls.Button;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class Main extends Sprite {
		
		[Embed(source = "test/bitmap.png")]
		private var bmpCla:Class;
		
		private var _btn:Button
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var bmp:Bitmap = new bmpCla() as Bitmap;
			var scaleBmp:ScaleBitmap = new ScaleBitmap(bmp.bitmapData);
			scaleBmp.scale9Grid=new Rectangle(20,20,80,80);
			
			_btn = new Button();
			_btn.setStyle("upSkin", scaleBmp);
			_btn.setStyle("overSkin", scaleBmp);
			_btn.setStyle("downSkin", scaleBmp);
			_btn.move(100, 100);
			addChild(_btn);
			
			//_btn.setSharedStyle
			
			_btn.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void {
			_btn.width = 100;
			_btn.height = 100;
		}
		
	}
	
}