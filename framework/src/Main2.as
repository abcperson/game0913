package  {
	import debug.Stats;
	import dis.ABitmap;
	import dis.AScaleBitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import res.InitConfigLoader;
	import res.ResManager;
	import ui.APanel;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class Main2 extends Sprite {
		
		private var _gameContainer:Sprite = new Sprite();	//游戏舞台，用来显示游戏
		
		public function Main2() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addChild(_gameContainer);
			InitConfigLoader.loadConfig(onInitConfigLoad);
			
			//内存监视
			addChild(new Stats());
		}
		
		//初始化配置加载完成后  初始化资源加载器
		private function onInitConfigLoad():void {
			ResManager.initRes();
			
			//var bmp:ABitmap = new ABitmap("init", "bmp");
			//bmp.x = 100;
			//bmp.y = 100;
			//_gameContainer.addChild(bmp);
			
			var bmp:AScaleBitmap = new AScaleBitmap("init", "bmp");
			bmp.x = 100;
			bmp.y = 100;
			_gameContainer.addChild(bmp);
			
			//var panel:APanel = new APanel(100, 100);
			//panel.x = 300;
			//panel.y = 100;
			//_gameContainer.addChild(panel);
		}
		
	}

}