package res {
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import flash.utils.Dictionary;
	/**
	 * 管理UI资源
	 * 1. 增加资源种类区分，在ResInfo内部对不同种类资源不同处理
	 * @author TJJTDS
	 */
	public class ResManager {
		
		//主加载 Loader 用来加载全部资源
		private static var _mainLoader:LoaderMax = new LoaderMax( { maxConnections:4, onComplete:loadComplete, 
				onChildComplete:childLoadComplete, onChildFail:childLoadedFail, onError:onError } );	//整个游戏唯一Loader
		
		//辅助loader  被add到主loader，加载过程中显示加载进度
		private static var _alertLoader:LoaderMax = new LoaderMax({onProgress:onAlertProgress, onComplete:onAlertComplete});
				
				
		//全部资源的索引
		private static var _resDic:Dictionary;
		
		//初始化资源索引 
		public static function initRes():void {
			if (_resDic != null) {
				return;
			}
			_resDic = new Dictionary();
			
			var xml:Object = InitConfigLoader.getConfig("resUrl.xml").content.data;
			parseResXML(xml);
		}
		
		private static function parseResXML(xml:Object):void {
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
			info.loadRes($callBack);
		}
		
		public static function getRes($mod:String, $name:String):ResInfo {
			return _resDic[$mod][$name] as ResInfo;
		}
		
		private static function childLoadComplete(evt:LoaderEvent):void {
			trace("child loadComplete");
		}
		
		private static function childLoadedFail(evt:LoaderEvent):void 
		{
			trace("child load fail");
		}
		
		private static function loadComplete(evt:LoaderEvent):void {
			trace("all loadComplete");
			
		}
		
		private static function onError(e:LoaderEvent):void {
			trace("error");
		}
		
		//可见的加载进度显示
		private static function onAlertProgress(e:LoaderEvent):void {
			
		}
		
		//可见的加载完成
		private static function onAlertComplete(e:LoaderEvent):void {
			
		}
		
		//获取loader
		public static function get mainLoader():LoaderMax {
			return _mainLoader;
		}
	}

}