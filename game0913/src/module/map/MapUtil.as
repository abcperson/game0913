package module.map {
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class MapUtil {
		
		//获取根据行、列获取字典索引
		public static function getDicID($col:int, $row:int):int {
			return $col * 1000 + $row;
		}
		
	}

}