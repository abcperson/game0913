package common {
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import module.ModuleType;
	/**
	 * 相当于 UIManager 生成和管理各个显示窗口 包括地图
	 * @author TJJTDS
	 */
	public class Facade {
		
		public static var moduleDic:Dictionary = new Dictionary();
		
		public static function showModule($type:String, $data:Object=null):void {
			var mod:IModule = moduleDic[$type] as IModule;
			if (mod != null) {
				mod.init($data);
				return;
			}
			var ClassReference:Class
			try {				
				ClassReference = getDefinitionByName($type) as Class;
			}catch (err:Error){
				//不处理
			}
			if (ClassReference == null) {
				return;
			}
            mod = new ClassReference() as IModule;
			registModule($type, mod);
			mod.init($data);
		}
		
		//注册模块，并注册侦听
		private static function registModule($type:String, $mod:IModule):void {
			moduleDic[$type] = $mod;
		}
	}

}