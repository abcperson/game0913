package res {
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
		
		public function ResInfo() {
			
		}
		
		
	}

}