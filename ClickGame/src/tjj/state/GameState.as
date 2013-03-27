package tjj.state{
	import flash.geom.Point;
	import org.axgl.Ax;
	import org.axgl.AxGroup;
	import org.axgl.AxRect;
	import org.axgl.AxState;
	import org.axgl.particle.AxParticleEffect;
	import org.axgl.particle.AxParticleSystem;
	import org.axgl.render.AxBlendMode;
	import org.axgl.tilemap.AxTilemap;
	import org.axgl.util.AxRange;
	import tjj.entity.Enemy;
	import tjj.entity.Player;
	import tjj.util.GameConst;
	import tjj.util.Resource;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class GameState extends AxState {
		
		/**
		 * Our world tilemap.
		 */
		public var tilemap:AxTilemap;
		
		/**
		 * All game entities. 
		 */
		public var entities:AxGroup;
		
		private var enemies:AxGroup;	//敌人
		private var player:Player;		//自己
		
		/** Player bullets group */
		public var playerBullets:AxGroup = new AxGroup;
		
		/**
		 * All particles. 
		 */
		public var particles:AxGroup;
		
		public function GameState() {
			
		}
		
		override public function create():void {
			super.create();
			GameConst.game = this;
			
			// Load our tilemap
			tilemap = new AxTilemap().build(Resource.MAP, Resource.TILES, 24, 24);
			this.add(tilemap);
			
			add(particles = new AxGroup);
			
			// Add player bullets group, which we will collide with the enemies group
			this.add(playerBullets);
			
			// Create our player
			player = new Player(40, 60);
			this.add(player);
			
			// Set the camera to follow our player, but only in the bounds of the world
			Ax.camera.follow(player);
			Ax.camera.bounds = new AxRect(0, 0, tilemap.width, tilemap.height);
			
			enemies = new AxGroup();
			add(enemies);
			
			//for (var i:int = 0; i < 4; i++) {
				//enemies.add(new Enemy(100, 100));
			//}
			var enemy:Enemy = new Enemy(100, 100);
			enemy.checks([new Point(200, 100),new Point(400, 100)]);
			enemies.add(enemy);
			
			entities = new AxGroup;
			entities.add(player).add(enemies);
			
			
			//var shadow:AxParticleEffect = new AxParticleEffect("shadow", Resource.ROLE, 5);
			//shadow.xVelocity = new AxRange(0, 0);
			//shadow.yVelocity = new AxRange(0, 0);
			//shadow.lifetime = new AxRange(0.1, 0.1);
			//shadow.startAlpha = new AxRange(0.5, 0.5);
			//shadow.endAlpha = new AxRange(0, 0);
			//shadow.blend = AxBlendMode.PARTICLE;
			//particles.add(AxParticleSystem.register(shadow));
		}
		
		override public function update():void {
			super.update();
			
			// Collide all the entities with the tilemap
			Ax.collide(entities, tilemap);
			//Ax.collide(player, enemies);
			
			//if (player.velocity.x != 0 || player.velocity.y != 0) {
				//AxParticleSystem.emit("shadow", player.x, player.y);
			//}
		}
	}

}