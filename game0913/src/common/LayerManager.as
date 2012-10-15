package common {
	import flash.display.Sprite;
	/**
	 * 层级管理  整个游戏分两层 地图和UI
	 * @author TJJTDS
	 */
	public class LayerManager {
		
		public static var gameStage:Sprite;	//游戏舞台
		
		public static var mapLayer:Sprite = new Sprite();		//底层 显示地图
		public static var uiLayer:Sprite = new Sprite();		//窗口层，弹出窗口
		
		//初始化  在游戏舞台添加所有层
		public static function init($stage:Sprite):void {
			gameStage = $stage;
			gameStage.addChild(mapLayer);
			gameStage.addChild(uiLayer);
		}
		
	}

}