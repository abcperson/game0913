package common.movement
{
	import flash.geom.Rectangle;
	
	/**
	 * Base class for moving characters.
	 */
	public class Mover
	{
		protected var _edgeBehavior:String = BOUNCE;
		protected var _mass:Number = 1.0;
		protected var _maxSpeed:Number = 10;
		protected var _position:Vector2D;
		protected var _velocity:Vector2D;
		protected var _stage:Rectangle;
		protected var _rotation:Number;
		
		// potential edge behaviors
		public static const WRAP:String = "wrap";
		public static const BOUNCE:String = "bounce";
		
		protected var _tmpVector2D:Vector2D = new Vector2D()
		
		/**
		 * Constructor.
		 */
		public function Mover()
		{
			_position = new Vector2D();
			_velocity = new Vector2D();
		}
		
		/**
		 * Handles all basic motion. Should be called on each frame / timer interval.
		 */
		public function update():void
		{
			// make sure velocity stays within max speed.
			_velocity.truncate(_maxSpeed);
			
			// add velocity to position
			_position = _position.add(_velocity);
			
			// handle any edge behavior
			if(_edgeBehavior == WRAP)
			{
				wrap();
			}
			else if(_edgeBehavior == BOUNCE)
			{
				bounce();
			}
			
			// update position of sprite
			x = position.x;
			y = position.y;
			
			// rotate heading to match velocity
			rotation = _velocity.angle * 180 / Math.PI;
		}
		
		/**
		 * Causes character to bounce off edge if edge is hit.
		 */
		private function bounce():void
		{
			if(_stage != null)
			{
				if(position.x > _stage.right)
				{
					position.x = _stage.right;
					velocity.x *= -1;
				}
				else if(position.x < 0)
				{
					position.x = 0;
					velocity.x *= -1;
				}
				
				if(position.y > _stage.bottom)
				{
					position.y = _stage.bottom;
					velocity.y *= -1;
				}
				else if(position.y < 0)
				{
					position.y = 0;
					velocity.y *= -1;
				}
			}
		}
		
		/**
		 * Causes character to wrap around to opposite edge if edge is hit.
		 */
		private function wrap():void
		{
			if(_stage != null)
			{
				if(position.x > _stage.right) position.x = 0;
				if(position.x < 0) position.x = _stage.right;
				if(position.y > _stage.bottom) position.y = 0;
				if(position.y < 0) position.y = _stage.bottom;
			}
		}
		
		/**
		 * Sets / gets what will happen if character hits edge.
		 */
		public function set edgeBehavior(value:String):void
		{
			_edgeBehavior = value;
		}
		public function get edgeBehavior():String
		{
			return _edgeBehavior;
		}
		
		/**
		 * Sets / gets mass of character.
		 */
		public function set mass(value:Number):void
		{
			_mass = value;
		}
		public function get mass():Number
		{
			return _mass;
		}
		
		/**
		 * Sets / gets maximum speed of character.
		 */
		public function set maxSpeed(value:Number):void
		{
			_maxSpeed = value;
		}
		public function get maxSpeed():Number
		{
			return _maxSpeed;
		}
		
		/**
		 * Sets / gets position of character as a Vector2D.
		 */
		public function set position(value:Vector2D):void
		{
			_position = value;
			x = _position.x;
			y = _position.y;
		}
		public function get position():Vector2D
		{
			return _position;
		}
		
		/**
		 * Sets / gets velocity of character as a Vector2D.
		 */
		public function set velocity(value:Vector2D):void
		{
			_velocity = value;
		}
		public function get velocity():Vector2D
		{
			return _velocity;
		}
		
		/**
		 * Sets x position of character. Overrides Sprite.x to set internal Vector2D position as well.
		 */
		public function set x(value:Number):void
		{
			_position.x = value;
		}
		
		/**
		 * Sets y position of character. Overrides Sprite.y to set internal Vector2D position as well.
		 */
		public function set y(value:Number):void
		{
			_position.y = value;
		}
		
		public function get rotation():Number {
			return _rotation;
		}
		
		public function set rotation(value:Number):void {
			_rotation = value;
		}
		
	}
}