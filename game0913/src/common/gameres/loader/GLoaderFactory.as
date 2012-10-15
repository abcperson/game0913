package common.gameres.loader {
	import com.greensock.loading.core.LoaderItem;
	import common.gameres.GameResInfo;
	import common.gameres.GameResType;
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class GLoaderFactory {
		
		public static function makeLoader($resInfo:GameResInfo):IGLoaderItem {
			var loaderItem:IGLoaderItem;
			switch($resInfo.type) {
				case GameResType.BINARY:
					loaderItem = new GDataLoader($resInfo);
				break;
				case GameResType.BITMAP:
					loaderItem = new GImageLoader($resInfo);
				break;
			}
			return loaderItem;
		}
		
	}

}