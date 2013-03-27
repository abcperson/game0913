package tjj.util{
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class Resource {
		
		public static var MAP:String;
		
		[Embed(source="../../res/star.png")]
		public static const STAR:Class;
		
		[Embed(source = "../../res/tiles.png")]
		public static const TILES:Class;
		
		[Embed(source="../../res/bullet.png")]
		public static const BULLET:Class;
		
		[Embed(source = "../../res/role.png")]
		public static const ROLE:Class;
	}

}