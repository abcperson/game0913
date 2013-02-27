package  {
	import flash.geom.Point;
	import org.axgl.Ax;
	import org.axgl.AxSprite;
	import org.axgl.AxU;
	import org.axgl.input.AxMouseButton;
	import org.axgl.particle.AxParticleEffect;
	import org.axgl.util.AxRange;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class Player extends AxSprite {
		
		private var speed:int = 200;
		/**
		 * Timer to keep track of how often to fire a bullet
		 */
		public var fireDelay:Number = 0;
		
		public function Player(x:uint, y:uint) {
			GameConst.targetPoint.x = x;
			GameConst.targetPoint.y = y;
			
			super(x, y, Resource.STAR, 23, 23);
		}
		
		override public function update():void {
			if (Ax.mouse.pressed(AxMouseButton.LEFT)) {
				GameConst.targetPoint.x = Ax.mouse.x;
				GameConst.targetPoint.y = Ax.mouse.y;
			}
			
			if (AxU.distance(x,y, GameConst.targetPoint.x - width / 2, GameConst.targetPoint.y - height / 2) > speed * Ax.dt) {
				var angle:Number = AxU.getAngle(x , y , GameConst.targetPoint.x - width / 2, GameConst.targetPoint.y - height / 2);
				
				velocity.x = speed * Math.cos(angle);
				velocity.y = speed * Math.sin(angle);
			} else {
				velocity.x = velocity.y = 0;
				x = GameConst.targetPoint.x - width / 2;
				y = GameConst.targetPoint.y - height / 2;
			}
			
			if (Ax.mouse.down(AxMouseButton.RIGHT) && fireDelay <= 0) {
				shoot();
				fireDelay = 0.6;
			}
			fireDelay -= Ax.dt;
			
			super.update();
		}
		
		/**
		 * Shoots 1 bullet, plus one for each spread powerup you've obtained
		 */
		private function shoot():void {
			var angle:Number = AxU.getAngle(x , y , Ax.mouse.x - width / 2, Ax.mouse.y - height / 2);
			Bullet.create(this.x + width/2, this.y + height/2, angle, 200, GameConst.game.playerBullets);
		}
	}

}