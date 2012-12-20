package res {
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderItem;
	import com.greensock.loading.data.ImageLoaderVars;
	import com.greensock.loading.data.SWFLoaderVars;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	import util.pools.ObjectPool;
	/**
	 * 管理资源加载
	 * bitmap 用bitmapData记录保存
	 * class 动画用对象池保存
	 * @author TJJTDS
	 */
	public class ResManager {
		
		private static var _resDic:Dictionary = new Dictionary();
		
		private static var _mainLoader:LoaderMax = new LoaderMax( { maxConnections:4, onComplete:loadComplete, 
				onChildComplete:childLoadComplete, onChildFail:childLoadedFail, onError:onError});	//整个游戏唯一Loader
		
		public function ResManager() {
			
		}
		
		
		public static function loadRes(url:String, callBack:Function = null, isShowLoading:Boolean = false):void {
			//区分 bmp 或者 swf
			var resInfo:ResInfo = _resDic[url] as ResInfo;
			//已经加载过的资源直接调用回调 返回
			if (resInfo) {
				if (callBack != null) 	callBack(resInfo);
				return;
			}
			//正在加载的资源添加回调
			var loaderItem:LoaderItem =  _mainLoader.getLoader(url);
			if (loaderItem != null) {				
				var info:ResInfo = loaderItem.vars["resInfo"] as ResInfo;
				info.callbacks.push(callBack);
				return;
			}
			//没加载过的资源添加新loader
			resInfo = new ResInfo(url);
			if(callBack != null) resInfo.addCallback(callBack);
			if (resInfo.type == ResType.JPG || resInfo.type == ResType.PNG) {
				var imgVar:ImageLoaderVars = new ImageLoaderVars();
				imgVar.prop("resInfo", resInfo);
				loaderItem = new ImageLoader(resInfo.wholeUrl, imgVar);
			}else if (resInfo.type == ResType.SWF) {
				var swfVar:SWFLoaderVars = new SWFLoaderVars();
				swfVar.prop("resInfo", resInfo);
				swfVar.context(new LoaderContext(false, ApplicationDomain.currentDomain));
				loaderItem = new SWFLoader(resInfo.wholeUrl, swfVar);
			}
			_mainLoader.append(loaderItem);
			_mainLoader.load();
		}
		
		public static function getBitmap(url:String):BitmapData {
			var resInfo:ResInfo = _resDic[url] as ResInfo;
			if (resInfo.bmp) {
				return resInfo.bmp;
			}
			return null;
		}
		
		public static function getMovieclip(symbolName:String):DisplayObject {
			if (ApplicationDomain.currentDomain.hasDefinition(symbolName)) {
				var cla:Class = ApplicationDomain.currentDomain.getDefinition(symbolName) as Class;
				return ObjectPool.getObject(cla);
			}
			return null;
		}
		
		private static function childLoadComplete(evt:LoaderEvent):void {
			trace("child loadComplete");
			var resInfo:ResInfo;
			if (evt.target is ImageLoader) {
				var imgLoader:ImageLoader = evt.target as ImageLoader;
				resInfo = imgLoader.vars["resInfo"] as ResInfo;
				resInfo.bmp = (imgLoader.rawContent as Bitmap).bitmapData;	//设置加载到的bitmap
			}else if (evt.target is SWFLoader) {
				//不用处理
				var swfLoader:SWFLoader = evt.target as SWFLoader;
				resInfo = swfLoader.vars["resInfo"] as ResInfo;
			}
			_resDic[resInfo.url] = resInfo;		//添加到已加载字典
			//清除函数列表
			var fun:Function;
			while (resInfo.callbacks.length > 0) {
				fun = resInfo.callbacks.shift() as Function;
				fun(resInfo);
			}
			(evt.target as LoaderItem).dispose();
		}
		
		private static function childLoadedFail(evt:LoaderEvent):void {
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