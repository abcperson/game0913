package common.movement
{

	public class Circle
	{
		public var x:Number;
		public var y:Number;
		
		private var _radius:Number;
		private var _color:uint;
		
		public var tmpPos:Vector2D = new Vector2D();
		
		public function Circle(radius:Number, color:uint = 0x000000)
		{
			_radius = radius;
			_color = color;
		}
		
		public function get radius():Number
		{
			return _radius;
		}
		
		public function get position():Vector2D
		{
			tmpPos.x = x;
			tmpPos.y = y;
			return tmpPos;
		}
	}
}