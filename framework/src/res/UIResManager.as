package res {
	import flash.utils.Dictionary;
	/**
	 * 管理UI资源
	 * @author TJJTDS
	 */
	public class UIResManager {
		
		//全部资源的索引
		private static var _resDic:Dictionary;
		
		//初始化资源索引 
		public static function initRes():void {
			if (_resDic != null) {
				return;
			}
			_resDic = new Dictionary();
			
			var xml:Object = InitConfigLoader.getConfig("resUrl.xml").content.data;
			parseXML(xml);
		}
		
		private static function parseXML(xml:Object):void {
			var resInfo:ResInfo;
			for each (var obj:Object in xml.module) {
				for each (var item:Object in obj.item) {
					resInfo = new ResInfo();
					resInfo.module = obj.name;
					resInfo.preUrl = obj.preUrl;
					resInfo.name = item.name;
					resInfo.type = item.type;
					resInfo.url = item.url;
					_resDic[resInfo.module + "_" + resInfo.name] = resInfo;
				}
			}
		}
		
		public static function getRes():ResInfo {
			
		}
	}

}