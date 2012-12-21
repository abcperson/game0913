package {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	//import mod.MyMod;
	
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
			// entry point
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			//var bmp:Bitmap = new GameLib.testA;
			//addChild(bmp);
			
			//var bmp2:Bitmap = new GameLib.testB;
			//addChild(bmp2);
			
			GameLib
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			
			loader.load(new URLRequest("mod/MyMod.swf"), context);
			
			//addChild(new MyMod());
		}
		
		private function onLoadComplete(e:Event):void {
			var loaderInfo:LoaderInfo = e.currentTarget as LoaderInfo;
			//addChild(loaderInfo.content);
			
			var domain:ApplicationDomain = loaderInfo.applicationDomain;
			//var ModClass:Class = domain.getDefinition("mod.MyMod2") as Class;
			var func:Function = loaderInfo.content["makeClass"]();
			var myClass:Class = func.apply() as Class;
			addChild(new myClass());
			//addChild(new ModClass());
		}
		
	}
	
}