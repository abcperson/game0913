package {
	import cache.player.PlayerCache;
	import cache.player.PlayerInfo;
	import common.config.ConfigManager;
	import common.Facade;
	import common.LayerManager;
	import debug.Stats;
	import flash.display.Sprite;
	import flash.events.Event;
	import module.ModuleType;

	/**
	 * ...
	 * @author TJJTDS
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite {
		
		private var _gameContainer:Sprite = new Sprite();	//游戏舞台，用来显示游戏

		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(_gameContainer);
			// entry point
			//初始或获取人物信息	
			//MapConfig	根据人物信息PlayerInfo.mapName加载相关地图
			//加载完毕设置 MapCache
			PlayerCache.playerInfo = new PlayerInfo();
			
			//加载配置	完成后创建地图和人物
			ConfigManager.loadConfig(onLoadedConfig);
			
			//内存监视
			addChild(new Stats());
		}
		
		private function onLoadedConfig():void 
		{
			//添加各层到舞台
			LayerManager.init(_gameContainer);
			//创建地图
			Facade.showModule(ModuleType.MAP);
			//创建人物
		}
	}
}