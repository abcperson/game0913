package res {
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderStatus;
	import flash.display.Bitmap;
	/**
	 * 资源定义
	 * @author TJJTDS
	 */
	public class ResInfo {
		
		public var preUrl:String;	//路径前缀，在路径前面
		public var url:String;		//外部：路径 或者 嵌入：类的包路径
		public var type:int;		//类型：ResType
		public var name:String;		//资源名称
		public var module:String;	//模块名
		public var symbol:String;	//在swf里的symbol
		
		public var bmp:Bitmap;	//被加载到的图片
		
		private var _completeCallbacks:Array = [];	//加载完成回调
		
		public function ResInfo() {
			
		}
		
		public function loadRes($callBack:Function):void {
			if (bmp != null) {
				$callBack(this);
				return;
			}
			var loaderName:String = module + "_" + name;
			var imgLoader:ImageLoader = ResManager.mainLoader.getLoader(loaderName);
			if (imgLoader != null) {				
				if (imgLoader.status == LoaderStatus.LOADING || imgLoader.status == LoaderStatus.READY) {
					_completeCallbacks.push($callBack);
				}
			}
			imgLoader = new ImageLoader(url, {onChildComplete:onResComplete});
			
		}
		
		//资源加载完毕
		private function onResComplete(e:LoaderEvent):void {
			var fun:Function = _completeCallbacks.shift();
			while (fun != null) {
				fun(this);
			}
		}
		
	}

}