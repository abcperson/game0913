package module.map {
	import cache.map.MapCache;
	import cache.player.PlayerCache;
	import com.greensock.events.LoaderEvent;
	import common.IModule;
	import common.iso.IsoUtils;
	import common.LayerManager;
	import common.movement.Clock;
	import common.movement.Vector2D;
	import common.pools.ObjectPool;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import module.map.tile.GridTile;
	//import module.map.tile.GridTileNull;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class MapModule extends Sprite implements IModule {
		
		private var _clock:Clock = new Clock();
		private var _camara:MapCamara = new MapCamara();
		private var _visibleGridDic:Dictionary = new Dictionary();	//画面上可见的格子
		
		private var _gridLayer:Sprite = new Sprite();	//底层
		
		private var _tarX:int;
		private var _tarY:int;
		private var _lastCutMapTime:int;	//上次切地图时间
		private var _cutMapDelta:int = 250;	//切地图间隔时间，减少切地图次数
		
		public function MapModule() {
			addChild(_gridLayer);
			addEventListener(Event.ADDED_TO_STAGE, onAddStage);
		}
		
		private function onAddStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddStage);
			_camara.updateWidthHeight(stage.stageWidth, stage.stageHeight);
			stage.addEventListener(Event.RESIZE, onStageResize);
			
			stage.addEventListener(MouseEvent.CLICK, onClickStage);
			
			//var _bitmap:BitmapData = new BitmapData(3000, 3000, false, 0xff0000)
			//_bitmap.dispose();
		}
		
		private function onClickStage(e:MouseEvent):void {
			_tarX = mouseX;
			_tarY = mouseY;
		}
		
		private function onStageResize(e:Event):void {
			_camara.updateWidthHeight(stage.stageWidth, stage.stageHeight);
		}
		
		public function init($data:Object):void {
			MapConfig.load(onLoadData);
		}
		
		//加载完配置后，根据配置描绘地图
		private function onLoadData():void {
			
			LayerManager.mapLayer.addChild(this);
			
			_tarX = 0;
			_tarY = 1000;
			var mouseIsoPos:Vector2D = IsoUtils.screenToIso(_tarX, _tarY);
			PlayerCache.playerInfo.x = mouseIsoPos.x;
			PlayerCache.playerInfo.y = mouseIsoPos.y;
			_camara.setPos(_tarX, _tarY);
			_camara.moveMap(this);
			
			addEventListener(Event.ENTER_FRAME, run);
		}
		
		private function run(e:Event):void {
			//var curTime:int = getTimer();
			//每帧更新地图和人物
			var mouseIsoPos:Vector2D = IsoUtils.screenToIso(_tarX, _tarY);
			PlayerCache.playerInfo.x = mouseIsoPos.x;
			PlayerCache.playerInfo.y = mouseIsoPos.y;
			//更新镜头位置
			_camara.followMainRole();
			_camara.update();
			_camara.moveMap(this);
			
			//格子每帧更新，地图隔一段时间切掉
			if (_clock.time - _lastCutMapTime > _cutMapDelta) {				
				updateMap();
				_lastCutMapTime = _clock.time;
			}else {
				//暂时不需要每帧更新格子
				//updateTiles();
			}
			
			//var calTime:int = getTimer() - curTime;
			//trace(calTime);
		}
		
		//显示地图  更新地图 切除不显示部分
		private function updateMap():void {
			var mapCenX:int = _camara.x;
			var mapCenY:int = _camara.y;
			var isoPos:Vector2D = IsoUtils.screenToIso(mapCenX, mapCenY);
			var cenCol:int = Math.floor(isoPos.x / MapCache.mapInfo.tileHeight);
			var cenRow:int = Math.floor(isoPos.y / MapCache.mapInfo.tileHeight);
			
			var redDic:Dictionary = new Dictionary();	//下一帧要显示的全部格子的字典
			
			for each (var tmpArr:Array in MapCache.clipGridArr) {
				var redCol:int = cenCol + tmpArr[0];
				var redRow:int = cenRow + tmpArr[1];
				if (redCol < 0 || redCol >= MapCache.mapInfo.width) {
					continue;
				}
				if (redRow < 0 || redRow >= MapCache.mapInfo.height) {
					continue;
				}
				var tarID:int = MapUtil.getDicID(redCol, redRow);
				var redGrid:GridTile = _visibleGridDic[tarID] as GridTile;
				if (redGrid) {		//之前已经在显示  移动到新显示列表
					redDic[tarID] = redGrid;
					if (_visibleGridDic[tarID] != null) {
						_visibleGridDic[tarID] = null;
						delete _visibleGridDic[tarID];
					}
					redGrid.updateState();
				}else {
					var newGrid:GridTile = ObjectPool.getObject(GridTile);
					newGrid.show(_gridLayer, redCol, redRow);
					redDic[MapUtil.getDicID(redCol, redRow)] = newGrid;
				}
			}
			
			for each (var nullGrid:GridTile in _visibleGridDic) {
				nullGrid.hide();
				ObjectPool.disposeObject(nullGrid);
			}
			
			_visibleGridDic = redDic;
		}
		
		//显示地图  更新地图 切除不显示部分
		//private function updateMap():void {
			//var mapCenX:int = _camara.x;
			//var mapCenY:int = _camara.y;
			//var isoPos:Vector2D = IsoUtils.screenToIso(mapCenX, mapCenY);
			//var cenCol:int = Math.floor(isoPos.x / MapCache.mapInfo.tileHeight);
			//var cenRow:int = Math.floor(isoPos.y / MapCache.mapInfo.tileHeight);
			//
			//var redDic:Dictionary = new Dictionary();	//下一帧要显示的全部格子的字典
			//
			//for each (var tmpArr:Array in MapCache.clipGridArr) {
				//var redCol:int = cenCol + tmpArr[0];
				//var redRow:int = cenRow + tmpArr[1];
				//if (redCol < 0 || redCol >= MapCache.mapInfo.width) {
					//continue;
				//}
				//if (redRow < 0 || redRow >= MapCache.mapInfo.height) {
					//continue;
				//}
				//var tarID:int = MapUtil.getDicID(redCol, redRow);
				//var redGrid:GridTileNull = _visibleGridDic[tarID] as GridTileNull;
				//if (redGrid) {		//之前已经在显示  移动到新显示列表
					//redDic[tarID] = redGrid;
					//if (_visibleGridDic[tarID] != null) {
						//_visibleGridDic[tarID] = null;
						//delete _visibleGridDic[tarID];
					//}
					//redGrid.updateState();
				//}else {
					//var newGrid:GridTileNull = ObjectPool.getObject(GridTileNull);
					//newGrid.show(_gridLayer, redCol, redRow);
					//redDic[MapUtil.getDicID(redCol, redRow)] = newGrid;
				//}
			//}
			//
			//for each (var nullGrid:GridTileNull in _visibleGridDic) {
				//nullGrid.hide();
				//ObjectPool.disposeObject(nullGrid);
			//}
			//
			//_visibleGridDic = redDic;
		//}
		
		//更新每个格子
		//private function updateTiles():void {
			//for each(var tile:GridTileNull in _visibleGridDic) {
				//tile.updateState();
			//}
		//}
	}

}