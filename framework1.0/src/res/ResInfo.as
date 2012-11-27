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
		public var url:String;		//外部：路径
		public var type:int;		//类型：ResType
		public var name:String;		//资源名称
		public var module:String;	//模块名
		public var symbol:String;	//在swf里的symbol
		
		public var bmp:Bitmap;	//被加载到的图片
		
		public function ResInfo() {
			
		}
		
		
		
	}

}