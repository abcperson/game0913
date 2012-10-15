package module.map {
	import cache.map.MapCache;
	import cache.player.PlayerCache;
	import com.greensock.loading.LoaderMax;
	import common.config.ResConfig;
	import common.gameres.GameResManager;
	import common.gameres.ResConst;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import module.ModuleType;
	import tmx.TmxMap;
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class MapConfig {
		
		private static var xmls:Dictionary;
		private static var _onMapConfigLoad:Function;	//加载配置后调用的函数，在MapModule处理
		
		public static function load($onLoad:Function):void {
			_onMapConfigLoad = $onLoad
			GameResManager.loadRes(ResConst.mapdata, loadMapHandler);
		}
		
		static private function loadMapHandler():void {
			var binary:ByteArray = LoaderMax.getContent(ResConst.mapdata);
			binary.uncompress();
			xmls = binary.readObject() as Dictionary;
			
			//根据人物信息PlayerInfo.mapName加载相关地图
			//加载完毕设置 MapCache
			//设置缓存信息  MapCache保存当前地图的信息
			var obj:Object = xmls[PlayerCache.playerInfo.mapName];
			var xml:XML = obj.content;
			MapCache.mapInfo = new TmxMap(xml);
			
			ResConfig.instance.addTmxTileSetInfo(MapCache.mapInfo);
			
			_onMapConfigLoad();
		}
		
		
		
	}

}