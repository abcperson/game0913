package common.gameres.loader {
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public interface IGLoaderItem{
		
		function pushCompleteCallback($callback:Function):void;	//添加完成回调
		function shiftCompleteCallback():Function;	//吐出完成回调
		function get completeCallbackCount():int;	//获取回调数量个数
	}
	
}