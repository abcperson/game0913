package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class Main extends Sprite {
		
		public var container:Sprite = new Sprite();
		public var map:Sprite = new Sprite();
		public var wholeBmp:Sprite = new Sprite();
		
		private var _isDragging:Boolean;
		private var beforeMouseX:int;
		private var beforeMouseY:int;
		private var beforeMapX:int;
		private var beforeMapY:int;
		
		private var size:int = 10;
		private var tileWidth:int = size * 2;	//格子宽度
		private var tileHeight:int = size;		//格子高度
		private var setWidth:int = 2;		//一个图素有多少个格子宽
		private var setHeight:int = 2;		//一个图素多少个格子高
		private var bmpWidth:int = 2;		//一个分图有多少个图素宽
		private var bmpHeight:int = 2;		//一个分图有多少个图素高
		private var wholeWidth:int = 9;		//一个整图有多少个分图宽
		private var wholeHeight:int = 12;	//一个整图有多少个分图高
		
		private var _infoArr:Array = [];
		private var _nameBefore:String = "adv";
		private var _srcBefore:String = "adv/adv";
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addChild(container);
			container.addChild(map);
			container.addChild(wholeBmp);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			//var tile:Tile = new Tile(size);
			//map.addChild(tile);
			
			//算出地图有长宽多少个size
			var w:int = wholeWidth * bmpWidth * setWidth * 2;
			var h:int = wholeHeight * bmpHeight * setHeight;
			var needSize:int = Math.ceil(h/2 * 2 + w/2);
			
			var startY:int = Math.ceil((needSize - h) / 2 * 2);
			startY = startY + (setHeight - 1);
			var startX:int = 0 + (setHeight - 1);
			
			
			var i:int;
			var j:int;
			for (i = 0; i < needSize; i++) {
				_infoArr[i] = [];
				for (j = 0; j < needSize; j++) {
					_infoArr[i][j] = 0;
				}
			}
			//生成地图信息
			for (var k:int = 0; k < wholeWidth; k++) {
				for (var l:int = 0; l < wholeHeight; l++) {
					for (var m:int = 0; m < bmpWidth; m++) {
						for (var n:int = 0; n < bmpHeight; n++) {
							var perBmpWidth:int = setWidth * bmpWidth;
							var perBmpHeight:int = setHeight * bmpHeight;
							var widthOffset:int = perBmpWidth * k + m * setWidth;
							var heightOffset:int = perBmpHeight * l + n * setHeight;
							var tmpX:int = startX + widthOffset;
							var tmpY:int = startY - widthOffset;
							tmpX += heightOffset;
							tmpY += heightOffset;
							
							var perBmpSetCount:int = bmpWidth * bmpHeight;
							var setID:int = perBmpSetCount * (l * wholeWidth + k) + n * bmpWidth + m + 1;
							_infoArr[tmpX][tmpY] = setID;
						}
					}
				}
			}
			//画地图
			for (i = 0; i < needSize; i++) {
				for (j = 0; j < needSize; j++) {
					var tilePos:Point = IsoUtils.isoToScreen(i * size, j * size, 0);
					var tile:Tile = new Tile(size, _infoArr[i][j]);
					tile.x = tilePos.x;
					tile.y = tilePos.y;
					map.addChild(tile);
				}
			}
			//画大图片
			var rectY:int = startY - (setHeight - 1);
			var bmpPos:Point = IsoUtils.isoToScreen(0, startY * size, 0);
			var posX:int = bmpPos.x - size;
			wholeBmp.graphics.lineStyle(1, 0xFF0000);
			wholeBmp.graphics.moveTo(posX, bmpPos.y);
			wholeBmp.graphics.lineTo(posX + w * size, bmpPos.y);
			wholeBmp.graphics.lineTo(posX + w * size, bmpPos.y + h * size);
			wholeBmp.graphics.lineTo(posX, bmpPos.y + h * size);
			wholeBmp.graphics.lineTo(posX, bmpPos.y);
			wholeBmp.graphics.lineStyle();
			
			var xml:XML = <map version='1.0' orientation='isometric'></map>;
			xml.@width = needSize;
			xml.@height = needSize;
			xml.@tilewidth = 64;
			xml.@tileheight = 32;
			for (var o:int = 0; o < wholeHeight; o++) {
				for (var p:int = 0; p < wholeWidth; p++) {
					var tileSet:XML = <tileset></tileset>;
					tileSet.@tilewidth = setWidth * 32 * 2;
					tileSet.@tileheight = setHeight * 32;
					var perCount:int = bmpWidth * bmpHeight;
					tileSet.@firstgid = perCount * (o * wholeWidth + p) + 1;
					tileSet.@name = getTileSetName(o, p);
					var img:XML = <image trans="ff00ff"/>;
					img.@source = getSrc(o, p);
					img.@width = bmpWidth * setWidth * 32 * 2;
					img.@height = bmpHeight * setHeight * 32;
					tileSet.appendChild(img);
					xml.appendChild(tileSet);
				}
			}
			var layer:XML = <layer name="bg"></layer>;
			layer.@width = needSize;
			layer.@height = needSize;
			var data:XML = <data encoding="csv"></data>;
			data.appendChild(genData());
			layer.appendChild(data);
			xml.appendChild(layer);
			trace(xml);
		}
		
		private function genData():String {
			var res:String = "\n";
			var width:int = _infoArr.length;
			var height:int = (_infoArr[0] as Array).length;
			for (var i:int = 0; i < height; i++) {
				for (var j:int = 0; j < width; j++) {
					res += _infoArr[j][i] + ",";
				}
				res += "\n";
			}
			res = res.substring(0, res.length - 2) + "\n";
			return res;
		}
		
		
		private function onKeyUp(e:KeyboardEvent):void {
			if (e.keyCode == 32) {
				_isDragging = false;
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			}
		}
		
		//空格键按下 地图跟随鼠标移动
		private function onKeyDown(e:KeyboardEvent):void {
			if (e.keyCode == 32) {
				_isDragging = true;
				beforeMouseX = stage.mouseX;
				beforeMouseY = stage.mouseY;
				beforeMapX = container.x;
				beforeMapY = container.y;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			}
		}
		
		private function onMouseMove(e:MouseEvent):void {
			if (_isDragging == false) {
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				return;
			}
			//拖动状态下更新地图位置
			if (_isDragging) {
				var offsetX:int = stage.mouseX - beforeMouseX;
				var offsetY:int = stage.mouseY - beforeMouseY;
				container.x = beforeMapX + offsetX;
				container.y = beforeMapY + offsetY;
			}
		}
		
		//获取图片路径
		private function getSrc(i:int, j:int):String {
			return _srcBefore + "_" + makeNumStr(i) + "x" + makeNumStr(j) + ".jpg";
		}
		
		//获取图片名称
		private function getTileSetName(i:int, j:int):String {
			return _nameBefore + "_" + makeNumStr(i) + "x" + makeNumStr(j);
		}
		
		private function makeNumStr(num:int):String {
			var len:int = num.toString().length;
			if (len < 2) {
				var tmp:String = "00" + num.toString();
				return tmp.substring(tmp.length - 2, tmp.length);
			}
			return num.toString();
		}
	}
	
}