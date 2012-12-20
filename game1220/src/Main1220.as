package {
	import config.ConfigManager;
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
	public class Main1220 extends Sprite {
		
		public function Main1220():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			// entry point
			
			ConfigManager.initConfig("data/data", onConfigLoaded);
		}
		
		private function onConfigLoaded():void {
			trace("配置加载完毕");
			
		}
		
	}
	
}