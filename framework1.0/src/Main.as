package {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import res.ResInfo;
	import res.ResManager;
	import util.pools.ObjectPool;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class Main extends Sprite {
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			// entry point
			//ResManager.loadRes("http://imgsrc.baidu.com/forum/pic/item/5f2f930a304e251fcba6e9b0a786c9177f3e533b.jpg", onBmpLoaded);
			//ResManager.loadRes("http://imgsrc.baidu.com/forum/pic/item/5f2f930a304e251fcba6e9b0a786c9177f3e533b.jpg", onBmpLoaded);
			ResManager.loadRes("assets/wheel.swf", onSwfLoaded);
			ResManager.loadRes("assets/wheel.swf", onSwfLoaded);
			stage.addEventListener(MouseEvent.CLICK, onStageClick);
		}
		
		private function onStageClick(e:MouseEvent):void {
			//ResManager.loadRes("http://imgsrc.baidu.com/forum/pic/item/5f2f930a304e251fcba6e9b0a786c9177f3e533b.jpg", onBmpLoaded);
			ResManager.loadRes("assets/wheel.swf", onSwfLoaded);
		}
		
		private function onBmpLoaded(resInfo:ResInfo):void {
			var bmp:Bitmap = new Bitmap(resInfo.bmp);
			bmp.x = 1000 * Math.random();
			bmp.y = 800 * Math.random();
			addChild(bmp);
		}
		
		private var tmpDis:DisplayObject;
		private function onSwfLoaded(resInfo:ResInfo):void {
			if (tmpDis)	ObjectPool.disposeObject(tmpDis);
			var dis:DisplayObject = ResManager.getMovieclip("TestTestCom");
			dis.x = 1000 * Math.random();
			dis.y = 800 * Math.random();
			addChild(dis);
			tmpDis = dis;
		}
	}
	
}