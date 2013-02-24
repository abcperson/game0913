package  {
	import org.axgl.AxSprite;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class Enemy extends AxSprite {
		
		public function Enemy() {
			super(GameConst.tileMap.width * Math.random(), GameConst.tileMap.height * Math.random(), Resource.STAR);
			
			velocity.x = -100 + 200 * Math.random();
			velocity.y = -100 + 200 * Math.random();
		}
		
		override public function update():void {
			if (x < 0) {
				x = 0;
				velocity.x *= -1;
			}
			if (x > (GameConst.tileMap.width - this.width)) {
				x = GameConst.tileMap.width - this.width
				velocity.x *= -1;
			}
			if (y < 0) {
				y = 0;
				velocity.y *= -1;
			}
			if (y > (GameConst.tileMap.height - this.height)) {
				y = GameConst.tileMap.height - this.height;
				velocity.y *= -1;
			}
			
			super.update();
		}
	}

}