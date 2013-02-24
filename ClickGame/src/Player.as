package  {
	import org.axgl.Ax;
	import org.axgl.AxSprite;
	import org.axgl.AxU;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class Player extends AxSprite {
		
		private var speed:int = 200;
		
		public function Player(x:uint, y:uint) {
			GameConst.targetPoint.x = x;
			GameConst.targetPoint.y = y;
			
			super(x, y, Resource.STAR, 23, 23);
		}
		
		override public function update():void {
			if (AxU.distanceToMouse(x + width / 2, y + height / 2) > speed * Ax.dt) {
				var angle:Number = AxU.getAngleToMouse(x + width / 2, y + height / 2);
				
				velocity.x = speed * Math.cos(angle);
				velocity.y = speed * Math.sin(angle);
			} else {
				velocity.x = velocity.y = 0;
				//x = Ax.mouse.x - width / 2;
				//y = Ax.mouse.y - height / 2;
			}
			
			super.update();
		}
	}

}