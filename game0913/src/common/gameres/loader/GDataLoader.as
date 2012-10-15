package common.gameres.loader {
	import com.greensock.loading.data.DataLoaderVars;
	import com.greensock.loading.DataLoader;
	import common.config.PathConst;
	import common.gameres.GameResInfo;
	
	/**
	 * 数据加载  加载压缩后的配置文件
	 * @author TJJTDS
	 */
	public class GDataLoader extends DataLoader implements IGLoaderItem{
		
		private var _resInfo:GameResInfo;		//资源信息
		private var _completeCallbacks:Array = [];	//加载完成回调
		
		public function GDataLoader($resInfo:GameResInfo) {
			_resInfo = $resInfo;
			var dataVar:DataLoaderVars = new DataLoaderVars();
			dataVar.name($resInfo.name);
			dataVar.format("binary");
			super(PathConst.ASSETSURL + _resInfo.url, dataVar);
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