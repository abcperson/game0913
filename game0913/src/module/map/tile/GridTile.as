package module.map.tile {
	import cache.map.MapCache;
	import com.greensock.loading.display.ContentDisplay;
	import com.greensock.loading.LoaderMax;
	import common.gameres.GameResManager;
	import common.iso.IsoUtils;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import tmx.TmxLayer;
	import tmx.TmxTileSet;
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class GridTile {
		
		private var _col:int;	//行
		private var _row:int;	//列
		private var _bgParent:DisplayObjectContainer;	//背景容器
		private var _bmp:Bitmap;
		private var _bmpda:BitmapData;
		
		private var _gid:int;
		private var _tileSet:TmxTileSet;
		
		public function GridTile() {
			
		}
		
		public function setColRow($col:int, $row:int):void {
			_col = $col;
			_row = $row;
		}
		
		public function get col():int {
			return _col;
		}
		
		public function get row():int {
			return _row;
		}
		
		public function show($parent:DisplayObjectContainer, $col:int, $row:int):void {
			if (_bmpda) {
				_bmpda.dispose();
				_bmpda = null;
			}
			if (_bmp) {
				if(_bmp.parent)	_bmp.parent.removeChild(_bmp);
			}
			
			_bgParent = $parent;
			_col = $col;
			_row = $row;
			var bgLayer:TmxLayer = MapCache.mapInfo.getLayer("bg");
			var gidArr:Array = bgLayer.tileGIDs;
			_gid = gidArr[_row][_col];
			if (_gid > 0) {
				_tileSet = MapCache.mapInfo.getGidOwner(_gid);
				GameResManager.loadRes(_tileSet.name, onLoadBG);
			}else {
				_tileSet = null;
			}
		}
		
		private static var pos00:Point = new Point(0, 0);
		private static var copyRect:Rectangle = new Rectangle();
		
		private function onLoadBG():void {
			var dis:ContentDisplay = LoaderMax.getContent(_tileSet.name);
			var bmp:Bitmap = dis.rawContent;
			var offsetID:int = _gid - _tileSet.firstGID;
			copyRect.x = (offsetID % _tileSet.numCols) * _tileSet.tileWidth;
			copyRect.y = Math.floor(offsetID / _tileSet.numCols) * _tileSet.tileHeight;
			copyRect.width = _tileSet.tileWidth;
			copyRect.height = _tileSet.tileHeight;
			
			if (_bmpda == null) {
				_bmpda = new BitmapData(_tileSet.tileWidth, _tileSet.tileHeight, false, 0);
			}
			_bmpda.copyPixels(bmp.bitmapData, copyRect, pos00);
			if (_bmp == null) {
				_bmp = new Bitmap(_bmpda);
			}
			_bmp.bitmapData = _bmpda;
			
			var size:int = MapCache.mapInfo.tileHeight;
			var pos:Point = IsoUtils.isoToScreen(_col * size, _row * size, 0);
			var bmpX:int = pos.x - size;
			var bmpY:int = pos.y + size - _tileSet.tileHeight;
			_bmp.x = bmpX;
			_bmp.y = bmpY;
			_bgParent.addChild(_bmp);
		}
		
		//更新显示
		public function updateState():void {
			
		}
		
		public function hide():void {
			
		}
	}

}