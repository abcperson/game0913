package res {
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.data.LoaderMaxVars;
	import com.greensock.loading.DataLoader;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class InitConfigLoader {
		
		private static var xmls:Dictionary;
		private static var _onConfigLoad:Function;	//加载配置后调用的函数，在Main处理
		
		//加载初始化配置，进入游戏就加载的配置
		public static function loadConfig($onLoaded:Function):void {
			_onConfigLoad = $onLoaded;
			
			var loader:DataLoader = new DataLoader(PathConst.initData, {onComplete:onLoadConfig, format:"binary"});
			loader.load();
		}
		
		private static function onLoadConfig(event:LoaderEvent):void {
			var binary:ByteArray = event.target.content;
			binary.uncompress();
			xmls = binary.readObject() as Dictionary;
			
			_onConfigLoad();
		}
		
		public static function getConfig($fileName:String):Object {
			return xmls[$fileName];
		}
	}

}