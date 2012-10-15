package common.gameres 
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderItem;
	import com.greensock.loading.data.DataLoaderVars;
	import com.greensock.loading.data.LoaderMaxVars;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.LoaderStatus;
	import common.config.ConfigManager;
	import common.config.ResConfig;
	import common.gameres.loader.GLoaderFactory;
	import common.gameres.loader.IGLoaderItem;
	/**
	 * 用LoaderMax自带的管理Loader功能管理素材 素材包括配置和图片
	 * @author ...
	 */
	public class GameResManager 
	{
		private static var _allCompleteCallbacks:Array = [];	//加载完成回调
		
		private static var _mainLoader:LoaderMax = new LoaderMax( { maxConnections:4, onComplete:loadComplete, 
				onChildComplete:childLoadComplete, onChildFail:childLoadedFail, onError:onError});	//整个游戏唯一Loader
		
		//从resource.xml 查找并加载某个资源
		public static function loadRes($name:String, $callBack:Function):void {
			var resInfo:GameResInfo = ResConfig.instance.getResInfo($name);
			if (resInfo) {
				loadResByInfo(resInfo, $callBack);
			}else {
				throw new Error("加载不存在资源");
			}
		}
		
		//查看是否加载已完成的资源
		private static function checkIsLoadCompletedRes($name:String, $callBack:Function):Boolean {
			//已经加载的资源直接调用回调
			var loaderItem:LoaderItem = LoaderMax.getLoader($name);
			if (loaderItem != null) {
				if (loaderItem.status == LoaderStatus.COMPLETED) {
					if ($callBack != null) {
						$callBack();
					}
				}
				if (loaderItem.status == LoaderStatus.LOADING || loaderItem.status == LoaderStatus.READY) 
				{
					(loaderItem as IGLoaderItem).pushCompleteCallback($callBack);
				}
				return true;
			}
			return false;
		}
		
		//加载资源，根据资源信息
		public static function loadResByInfo($resInfo:GameResInfo, $callBack:Function):void {
			if (checkIsLoadCompletedRes($resInfo.name, $callBack)) {
				return;
			}
			var loader:IGLoaderItem = GLoaderFactory.makeLoader($resInfo);
			if ($callBack != null) {				
				loader.pushCompleteCallback($callBack);
			}
			_mainLoader.append(loader as LoaderItem);
			_mainLoader.load();
		}
		
		
		//加载多个资源	在全部完成的时候 调用回调
		public static function loadResMulti($resArr:Array, $callBack:Function):void {
			for (var i:int = 0; i < $resArr.length; i++) {
				loadRes($resArr[i], null);
			}
			if ($callBack != null) {				
				_allCompleteCallbacks.push($callBack);
			}
		}
		
		private static function childLoadComplete(evt:LoaderEvent):void {
			var loaderItem:IGLoaderItem = evt.target as IGLoaderItem;
			//执行全部回调函数
			while (loaderItem.completeCallbackCount > 0) {
				var fun:Function = loaderItem.shiftCompleteCallback();
				fun();
			}
			trace("child loadComplete");
		}
		
		private static function childLoadedFail(evt:LoaderEvent):void 
		{
			trace("child load fail");
		}
		
		private static function loadComplete(evt:LoaderEvent):void {
			trace("all loadComplete");
			while (_allCompleteCallbacks.length > 0) {
				var fun:Function = _allCompleteCallbacks.shift();
				fun();
			}
		}
		
		private static function onError(e:LoaderEvent):void {
			trace("error");
		}
		
		
	}

}