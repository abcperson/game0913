package config {
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class ConfigManager {
		
		private static var xmls:Dictionary;
		private static var _onConfigLoaded:Function;	//加载配置后调用的函数，在Main处理
		
		public static function initConfig(url:String, $onLoaded:Function):void{
			_onConfigLoaded = $onLoaded;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, onLoaded);
			loader.load(new URLRequest(url));
		}
		
		static private function onLoaded(e:Event):void {
			var binary:ByteArray = (e.target as URLLoader).data as ByteArray;
			binary.uncompress();
			xmls = binary.readObject() as Dictionary;
			
			_onConfigLoaded();
		}
		
		public static function getConfig($fileName:String):Object {
			return xmls[$fileName];
		}
	}

}