package  {
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderCore;
	import com.greensock.loading.data.LoaderMaxVars;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.LoaderStatus;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class Main5 extends Sprite {
		
		private var _loader:LoaderMax;
		
		public function Main5() {
			LoaderMax.activate([ImageLoader]);
			var loaderVar:LoaderMaxVars = new LoaderMaxVars();
			loaderVar.maxConnections(2);
			loaderVar.onChildComplete(onChildComplete);
			loaderVar.onProgress(onProgress);
			loaderVar.onComplete(onAllComplete);
			_loader = new LoaderMax(loaderVar);
			_loader.append(new ImageLoader("http://www.greensock.com/_img/loadermax/full_size/agencynet.jpg", {name:"a", onProgress:onChildAProgress}));
			_loader.append(new ImageLoader("http://www.greensock.com/_img/loadermax/full_size/buick.jpg", {name:"b", onProgress:onChildBProgress}));
			_loader.load(true);
			
			var tmpLoader:LoaderMax = new LoaderMax( { onProgress:onTmpProgress, onComplete:onTempComplete} );
			_loader.append(tmpLoader);
			tmpLoader.append(new ImageLoader("http://www.greensock.com/_img/loadermax/full_size/cocacola.jpg", {name:"b"}));
			tmpLoader.append(new ImageLoader("http://www.greensock.com/_img/loadermax/full_size/cu3er.jpg", {name:"c"}));
			tmpLoader.append(new ImageLoader("http://www.greensock.com/_img/loadermax/full_size/diva.jpg", {name:"d"}));
			tmpLoader.append(new ImageLoader("http://www.greensock.com/_img/loadermax/full_size/dow.jpg", {name:"e"}));
			tmpLoader.prioritize();
			//_loader.load(true);
		}
		
		private function onTempComplete(e:LoaderEvent):void {
			trace("tmp Complete");
			var _tmploader:LoaderMax = e.target as LoaderMax;
			var arr:Array = (e.target as LoaderMax).getChildren();
			for each (var loder:LoaderCore in arr) {
				_loader.append(loder);
				_tmploader.remove(loder);
			}
			trace(_loader.numChildren);
			var test:LoaderCore = _loader.getLoader("e");
			addChild(test.content);
		}
		
		private function onTmpProgress(e:LoaderEvent):void {
			var a:int = 0;
			var b:int = 0;
			var arr:Array = (e.target as LoaderMax).getChildren();
			for each (var loder:LoaderCore in arr) {
				if (loder.status == LoaderStatus.COMPLETED) {
					a ++;
				}
				b ++;
			}
			trace("tmp progress: " + e.target.progress + "  " + a + "/" + b + "  " + e.target.status);
		}
		
		private function onProgress(e:LoaderEvent):void {
			trace("main progress: " + e.target.progress);
		}
		
		private function onChildAProgress(e:LoaderEvent):void {
			trace("child A progress: " + e.target.progress);
		}
		
		private function onChildBProgress(e:LoaderEvent):void {
			trace("child B progress: " + e.target.progress);
		}
		
		private function onChildComplete(e:LoaderEvent):void {
			trace("child complete");
		}
		
		private function onAllComplete(e:LoaderEvent):void {
			trace("all complete");
		}
	}

}