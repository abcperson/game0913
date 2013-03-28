package tjj.util {
	import flash.geom.Point;
	import org.axgl.Ax;
	import org.axgl.AxEntity;
	import org.axgl.AxU;
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class AIUtil {
		
		//使物体移动向某个点	到达返回 true 未到返回 false
		public static function walkTo(entity:AxEntity, target:Point, maxSpeed:Number, offsetX:Number, offsetY:Number):Boolean {
			if (AxU.distance(entity.x, entity.y, target.x - offsetX, target.y - offsetY) > maxSpeed * Ax.dt) {
				var angle:Number = AxU.getAngle(entity.x , entity.y , target.x - offsetX, target.y - offsetY);
				
				entity.velocity.x = maxSpeed * Math.cos(angle);
				entity.velocity.y = maxSpeed * Math.sin(angle);
				
				return false;
			} else {
				entity.velocity.x = entity.velocity.y = 0;
				entity.x = target.x - offsetX;
				entity.y = target.y - offsetY;
				
				return true;
			}
		}
		
		//获取两个物体间的距离
		public static function getCenterDisOfEntitys(a:AxEntity, b:AxEntity):Number {
			return AxU.distance(a.center.x, a.center.y, b.center.x, b.center.y);
		}
		
		//限制物体在某个区域
		public static function boundsEntity(entity:AxEntity, boundX:Number, boundY:Number, boundWidth:Number, boundHeight:Number):void {
			if (entity.x < boundX) {
				entity.x = boundX;
				entity.velocity.x *= -1;
			}
			if (entity.x > (boundX + boundWidth - entity.width)) {
				entity.x = boundX + boundWidth - entity.width;
				entity.velocity.x *= -1;
			}
			if (entity.y < boundY) {
				entity.y = boundY;
				entity.velocity.y *= -1;
			}
			if (entity.y > (boundY + boundHeight - entity.height)) {
				entity.y = boundY + boundHeight - entity.height;
				entity.velocity.y *= -1;
			}
		}
	}

}