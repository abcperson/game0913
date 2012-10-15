package module.map.tile 
{
	import cache.map.MapCache;
	import common.iso.IsoUtils;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class GridTileNull extends Sprite {
		
		[Embed(source="../../../../bin/data/assest/grid.png")]
		public static const Grid:Class;
		
		[Embed(source = "../../../../bin/data/assest/redGrid.png")]
		public static const RedGrid:Class;
		
		
		private var _col:int;	//行
		private var _row:int;	//列
		
		private var _nullBmp:Bitmap = new Grid;
		private var _redBmp:Bitmap = new RedGrid;
		private var _text:TextField = new TextField();
		
		public function GridTileNull() {
			_nullBmp.x = -32;
			_nullBmp.y = 0;
			addChild(_nullBmp);
			
			_text.width = 50;
			_text.height = 20;
			_text.x = -25;
			_text.y = 6;
			var forMat:TextFormat = new TextFormat("宋体", 12, 0);
			_text.autoSize = TextFieldAutoSize.CENTER;
			_text.defaultTextFormat = forMat;
			
		}
		
		public function setColRow($col:int, $row:int):void {
			_col = $col;
			_row = $row;
			var wid:int = MapCache.mapInfo.tileHeight;
			var hei:int = MapCache.mapInfo.tileHeight;
			var pos:Point = IsoUtils.isoToScreen(_col * wid, _row * hei, 0);
			this.x = pos.x;
			this.y = pos.y;
			
			updateState();
		}
		
		public function get col():int {
			return _col;
		}
		
		public function get row():int {
			return _row;
		}
		
		//更新显示
		public function updateState():void {
			//根据格子信息更新显示
			//var gridInfo:GridInfo = Cache.mapCache.gridsInfoArr[col][row] as GridInfo;
			//if (gridInfo.state == 1) {
				//showRedOnly(true);
			//}else {
				//showRedOnly(false);
			//}
		}
		
		//将格子设成红色
		public function showRedOnly($bool:Boolean):void {
			if ($bool) {
				if (_nullBmp.parent != null) {
					removeChild(_nullBmp);
				}
				if (_redBmp.parent == null) {
					_redBmp.x = -32;
					_redBmp.y = 0;
					addChild(_redBmp);
				}
			}else {
				if (_redBmp.parent != null) {
					removeChild(_redBmp);
				}
				if (_nullBmp.parent == null) {
					_nullBmp.x = -32;
					_nullBmp.y = 0;
					addChild(_nullBmp);
				}
			}
		}
		
		//显示红色并且设置缓存数据    点击地图点时处理
		public function showRedAndSetInfo($bool:Boolean):void {
			//var gridInfo:GridInfo = Cache.mapCache.gridsInfoArr[col][row] as GridInfo;
			//if ($bool) {
				//gridInfo.state = 1;
			//}else {
				//gridInfo.state = 0;
			//}
			showRedOnly($bool);
		}
		
		public function show($parent:Sprite, $col:int, $row:int):void {
			this.setColRow($col, $row);
			$parent.addChild(this);
		}
		
		public function hide():void {
			if (this.parent) {
				parent.removeChild(this);
			}
		}
		
		public function changeState():void {
			//var gridInfo:GridInfo = Cache.mapCache.gridsInfoArr[col][row] as GridInfo;
			//if (gridInfo.state == 0) {
				showRedAndSetInfo(true);
			//}else {
				//showRedAndSetInfo(false);
			//}
		}
	}

}