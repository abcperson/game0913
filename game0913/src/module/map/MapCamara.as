package module.map {
	import cache.map.MapCache;
	import cache.player.PlayerCache;
	import common.iso.IsoUtils;
	import common.movement.SteeredMover;
	import common.movement.Vector2D;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class MapCamara {
		
		public var width:int;
		public var height:int;
		
		private var _mover:SteeredMover = new SteeredMover();
		
		public function MapCamara() {
			
		}
		
		public function get x():int {
			return _mover.position.x;
		}
		
		public function get y():int {
			return _mover.position.y;
		}
		
		public function get left():int {
			return _mover.position.x - width/2;
		}
		
		public function get top():int {
			return _mover.position.y - height/2;
		}
		
		public function updateWidthHeight($width:int, $height:int):void {
			width = $width;
			height = $height;
			generateClipGrids();
		}
		
		//生成用于切屏的 相对于 0,0 格子的 格子数组
		private function generateClipGrids():void {
			var res:Array = [];
			var gridSize:int = MapCache.mapInfo.tileHeight;
			var checkWidth:int = width / 2 + gridSize * 2;
			var checkHeight:int = height / 2 + gridSize;
			var wideCount:int = checkWidth / gridSize;
			var heiCount:int = checkHeight / (gridSize / 2);
			var rolCount:int = Math.max(wideCount, heiCount);	//遍历的 iso 行列数
			for (var i:int = -rolCount; i < rolCount; i++) {
				for (var j:int = -rolCount; j < rolCount; j++) {
					var isoX:int = i * gridSize;
					var isoZ:int = j * gridSize;
					var screenPos:Point = IsoUtils.isoToScreen(isoX, isoZ, 0);
					var screenX:int = Math.abs(screenPos.x);
					var screenY:int = Math.abs(screenPos.y);
					if (screenX < checkWidth && screenY < checkHeight) {
						res.push([i , j]);
					}
				}
			}
			MapCache.clipGridArr = res;
		}
		
		//跟随主角
		public function followMainRole():void {
			//根据主角屏幕位置
			var rolePos:Point = IsoUtils.isoToScreen(PlayerCache.playerInfo.x, PlayerCache.playerInfo.y, PlayerCache.playerInfo.z);
			_mover.arrive(rolePos.x, rolePos.y);
		}
		
		public function update():void {
			_mover.update();
		}
		
		private static var _tmpVector:Vector2D = new Vector2D();
		public function setPos($x:int, $y:int):void {
			_tmpVector.x = $x;
			_tmpVector.y = $y;
			_mover.position = _tmpVector;
		}
		
		public function moveMap($map:Sprite):void {
			$map.x = -(x - width / 2);
			$map.y = -(y - height / 2);
		}
	}

}