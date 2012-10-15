package common.iso
{
	import common.movement.Vector2D;
	import flash.geom.Point;
	
	public class IsoUtils
	{
		// a more accurate version of 1.2247...
		public static const Y_CORRECT:Number = Math.cos( -Math.PI / 6) * Math.SQRT2;
		
		public static var tmpPoint:Point = new Point();
		public static var tmpVector2D:Vector2D = new Vector2D();
		
		/**
		 * Converts a 3D point in isometric space to a 2D screen position.
		 * @arg pos the 3D point.
		 */
		public static function isoToScreen(x:Number, y:Number, z:Number):Point
		{
			var screenX:Number = x - y;
			var screenY:Number = z * Y_CORRECT + (x + y) * .5;
			tmpPoint.x = screenX;
			tmpPoint.y = screenY;
			return tmpPoint;
		}
		
		/**
		 * Converts a 2D screen position to a 3D point in isometric space, assuming y = 0.
		 * @arg point the 2D point.
		 */
		public static function screenToIso(x:Number, y:Number):Vector2D
		{
			var xpos:Number = y + x * .5;
			var ypos:Number = 0;
			var zpos:Number = y - x * .5;
			tmpVector2D.x = xpos;
			tmpVector2D.y = zpos;
			tmpVector2D.z = ypos;
			return tmpVector2D;
		}
		
	}
}