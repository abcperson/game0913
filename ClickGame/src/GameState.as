package  {
	import org.axgl.Ax;
	import org.axgl.AxGroup;
	import org.axgl.AxRect;
	import org.axgl.AxState;
	import org.axgl.tilemap.AxTilemap;
	
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
		
		public function GameState() {
			
		}
		
		override public function create():void {
			super.create();
			
			// Load our tilemap
			tilemap = new AxTilemap().build(Resource.MAP, Resource.TILES, 24, 24);
			this.add(tilemap);
			GameConst.tileMap = tilemap;
			
			// Create our player
			player = new Player(40, 60);
			this.add(player);
			
			// Set the camera to follow our player, but only in the bounds of the world
			Ax.camera.follow(player);
			Ax.camera.bounds = new AxRect(0, 0, tilemap.width, tilemap.height);
			
			enemies = new AxGroup();
			add(enemies);
			
			for (var i:int = 0; i < 4; i++) {
				enemies.add(new Enemy());
			}
			
			entities = new AxGroup;
			entities.add(player).add(enemies);
		}
		
		override public function update():void {
			super.update();
			
			// Collide all the entities with the tilemap
			Ax.collide(entities, tilemap);
		}
	}

}