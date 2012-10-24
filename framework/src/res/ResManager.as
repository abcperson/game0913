package res {
	import flash.utils.Dictionary;
	/**
	 * 管理UI资源
	 * 1. 增加资源种类区分，在ResInfo内部对不同种类资源不同处理
	 * @author TJJTDS
	 */
	public class ResManager {
		
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
				_resDic[obj.name] = new Dictionary();
				for each (var item:Object in obj.item) {
					resInfo = new ResInfo();
					resInfo.module = obj.name;
					resInfo.preUrl = obj.preUrl;
					resInfo.name = item.name;
					resInfo.type = item.type;
					resInfo.url = item.url;
					(_resDic[obj.name] as Dictionary)[resInfo.name] = resInfo;
				}
			}
		}
		
		public static function useRes($mod:String, $name:String, $callBack:Function):void {
			var info:ResInfo = getRes($mod, $name);
			if (info == null) {
				throw new Error("使用不存在的资源");
				return;
			}
			
		}
		
		public static function getRes($mod:String, $name:String):ResInfo {
			return _resDic[$mod][$name] as ResInfo;
		}
		
		
	}

}