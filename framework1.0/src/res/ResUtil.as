package res {
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class ResUtil {
		
		//获取路径后缀
		public static function getUrlSuffix(url:String):String {
			var str:String = url.slice(url.length - 3, url.length).toLowerCase();
			return str;
		}
		
	}

}