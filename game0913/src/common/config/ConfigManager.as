package common.config 
{
	import com.greensock.loading.LoaderMax;
	import common.gameres.GameResInfo;
	import common.gameres.GameResManager;
	import common.gameres.GameResType;
	import common.gameres.ResConst;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	/**
	 * 加载全局共用的配置 （与其他模块的配置区分 例如mapData）
	 * @author ...
	 */
	public class ConfigManager 
	{
		private static var xmls:Dictionary;
		private static var _onShareConfigLoad:Function;	//加载配置后调用的函数，在Main处理
		
		public static function loadConfig($onLoaded:Function):void {
			_onShareConfigLoad = $onLoaded;
			var resInfo:GameResInfo = new GameResInfo(ResConst.globalData, PathConst.RESDATA_CONFIG_URL, GameResType.BINARY);
			GameResManager.loadResByInfo(resInfo, loadShareDataHandler);
		}
		
		static private function loadShareDataHandler():void {
			var binary:ByteArray = LoaderMax.getContent(ResConst.globalData);
			binary.uncompress();
			xmls = binary.readObject() as Dictionary;
			
			_onShareConfigLoad();
		}
		
		public static function getConfig($fileName:String):Object {
			return xmls[$fileName];
		}
	}

}