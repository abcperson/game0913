package common.config 
{
	import common.gameres.GameResInfo;
	import common.gameres.GameResType;
	import flash.utils.Dictionary;
	import tmx.TmxMap;
	import tmx.TmxTileSet;
	/**
	 * ...
	 * @author ...
	 */
	public class ResConfig 
	{
		private static var _instance:ResConfig;
		
		private var _dic:Dictionary = new Dictionary();;
		
		public function ResConfig() 
		{
			if( _instance != null )
			{
				throw new Error(" ResConfig 单例 ");
			}
			init();
		}
		
		public static function get instance():ResConfig {
			if( _instance == null )
			{
				_instance = new ResConfig();
			}
			return _instance;
		}
		
		public function init():void {
			var obj:Object = ConfigManager.getConfig("resource.xml");
			
			var arr:Array = obj.content.root.item;
			for each(var item:Object in arr) {
				addResInfo(item.name, item.src, item.type);
			}
		}
		
		public function getResInfo($name:String):GameResInfo {
			return _dic[$name];
		}
		
		
		private function addResInfo($name:String, $url:String, $type:int ):void {
			var resInfo:GameResInfo = new GameResInfo($name, $url, $type);
			_dic[resInfo.name] = resInfo;
		}
		
		//地图配置加载后添加将地图里的tileset记录为资源信息
		public function addTmxTileSetInfo($map:TmxMap):void {
			var sets:Object = $map.tileSets;
			for each (var tileSet:TmxTileSet in sets) {
				addResInfo(tileSet.name, PathConst.MAP_PATH + tileSet.imageSource, GameResType.BITMAP);
			}
		}
	}

}