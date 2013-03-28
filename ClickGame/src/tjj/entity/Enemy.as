package tjj.entity{
	import flash.geom.Point;
	import org.axgl.AxSprite;
	import org.axgl.AxU;
	import tjj.util.AIUtil;
	import tjj.util.GameConst;
	import tjj.util.Resource;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class Enemy extends AxSprite {
		
		private var _checkPoints:Array = [];
		private var _checkingIndex:int;
		
		private var _alertDis:int = 100;
		
		public function Enemy(x:int, y:int) {
			//super(GameConst.game.tilemap.width * Math.random(), GameConst.game.tilemap.height * Math.random(), Resource.STAR);
			super(x, y, Resource.STAR);
			
			velocity.x = AxU.randf( -200, 200);
			velocity.y = AxU.randf( -200, 200);
		}
		
		public function checks(arr:Array):void {
			_checkPoints = arr;
			_checkingIndex = 0;
		}
		
		override public function update():void {
			AIUtil.boundsEntity(this, 0, 0, GameConst.game.tilemap.width, GameConst.game.tilemap.height);
			
			var isFindPlayer:Boolean = false;
			if (GameConst.game.player != null) {
				if (AIUtil.getCenterDisOfEntitys(this, GameConst.game.player) < _alertDis) {
					var tmpP:Point = new Point(GameConst.game.player.center.x, GameConst.game.player.center.y);
					AIUtil.walkTo(this, tmpP, 150, width / 2, height / 2);
					isFindPlayer = true;
				}
			}
			
			if (isFindPlayer == false) {
				var target:Point = _checkPoints[_checkingIndex];
				if (target) {
					if (AIUtil.walkTo(this, target, 150, width/2, height/2)) {
						_checkingIndex ++;
						if (_checkingIndex >= _checkPoints.length) {
							_checkingIndex = 0;
						}
					}
				}
			}
			
			
			super.update();
		}
	}

}