package common.gameres 
{
	import common.config.PathConst;
	import flash.utils.Dictionary;
	/**
	 * 图片资源，模型动画或地图瓦片用
	 * 三种情况：1 一个GameRes保存一张图片上的全部精灵序列图  2 保存动态生成的序列图  3 保存单张图片
	 * UI使用的图片不用GameRes管理
	 * 保存 callback 数组 加载完成 全部调用
	 * @author ...
	 */
	public class GameResInfo 
	{
		public var name:String;		//资源名称
		public var url:String;		//路径
		public var type:int;		//类型
		
		
		public function GameResInfo($name:String, $url:String, $type:int) 
		{
			name = $name;
			url = $url;
			type = $type;
		}
		
		
		
	}

}