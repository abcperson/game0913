package common.gameres.loader {
	import com.greensock.loading.data.ImageLoaderVars;
	import com.greensock.loading.ImageLoader;
	import common.config.PathConst;
	import common.gameres.GameResInfo;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class GImageLoader extends ImageLoader implements IGLoaderItem{
		
		private var _resInfo:GameResInfo;		//资源信息
		private var _completeCallbacks:Array = [];	//加载完成回调
		
		public function GImageLoader($resInfo:GameResInfo) {
			_resInfo = $resInfo;
			var dataVar:ImageLoaderVars = new ImageLoaderVars();
			dataVar.name($resInfo.name);
			super(_resInfo.url, dataVar);
		}
		
		//添加完成回调
		public function pushCompleteCallback($callback:Function):void 
		{
			_completeCallbacks.push($callback);
		}
		
		//吐出完成回调
		public function shiftCompleteCallback():Function 
		{
			return _completeCallbacks.shift();
		}
		
		//获取回调数量个数
		public function get completeCallbackCount():int 
		{
			return _completeCallbacks.length;
		}
	}

}