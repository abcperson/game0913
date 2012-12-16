package res {
	import com.greensock.loading.LoaderMax;
	import flash.utils.Dictionary;
	/**
	 * 管理资源加载
	 * bitmap 用bitmapData记录保存
	 * class 动画用对象池保存
	 * @author TJJTDS
	 */
	public class ResManager {
		
		private static var bmpDic:Dictionary = new Dictionary();
		private static var swfDic:Dictionary = new Dictionary();
		private static var _mainLoader:LoaderMax = new LoaderMax( { maxConnections:4, onComplete:loadComplete, 
				onChildComplete:childLoadComplete, onChildFail:childLoadedFail, onError:onError});	//整个游戏唯一Loader
		
		public function ResManager() {
			
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
	}

}