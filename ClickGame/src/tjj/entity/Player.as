package tjj.entity {
	import flash.geom.Point;
	import org.axgl.Ax;
	import org.axgl.AxSprite;
	import org.axgl.AxU;
	import org.axgl.input.AxMouseButton;
	import org.axgl.particle.AxParticleEffect;
	import org.axgl.util.AxRange;
	import tjj.util.AIUtil;
	import tjj.util.GameConst;
	import tjj.util.Resource;
	
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
			super(x, y, Resource.ROLE, 32, 49);
			
			scale.x = 1.5;
			scale.y = 1.5;
			//bounds(28, 12, 2, 38);
			bounds(42, 18, 3, 57);
			
			addAnimation("right", [0, 1, 2, 3], 5, true);
			addAnimation("up", [4, 5, 6, 7], 5, true);
			addAnimation("left", [8, 9, 10, 11], 5, true);
			addAnimation("down", [12, 13, 14, 15], 5, true);
			
		}
		
		override public function update():void {
			if (Ax.mouse.down(AxMouseButton.LEFT)) {
				GameConst.targetPoint.x = Ax.mouse.x;
				GameConst.targetPoint.y = Ax.mouse.y;
			}
			
			AIUtil.walkTo(this, GameConst.targetPoint, speed, width / 2, height / 2);
			
			if (Ax.mouse.down(AxMouseButton.RIGHT) && fireDelay <= 0) {
				shoot();
				fireDelay = 0.6;
			}
			fireDelay -= Ax.dt;
			
			if (velocity.y < 0 && Math.abs(velocity.y) > Math.abs(velocity.x) ) {
				animate("up");
			}else if (velocity.y > 0 && Math.abs(velocity.y) > Math.abs(velocity.x) ) {
				animate("down");
			}else if (velocity.x > 0 && Math.abs(velocity.y) < Math.abs(velocity.x) ) {
				animate("right");
			}else if (velocity.x < 0 && Math.abs(velocity.y) < Math.abs(velocity.x) ) {
				animate("left");
			}
			
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