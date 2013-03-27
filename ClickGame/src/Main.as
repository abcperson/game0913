package {
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import org.axgl.Ax;
	import org.axgl.render.AxColor;
	import tjj.state.GameState;
	import tjj.state.TitleState;
	import tjj.util.Resource;
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	public class Main extends Ax {
		
		private var myLoader:URLLoader;
		
		public function Main():void {
			super(TitleState);
			
			var XML_URL:String = "res/map.xml"; 
			var myXMLURL:URLRequest = new URLRequest(XML_URL); 
			myLoader = new URLLoader(myXMLURL); 
			myLoader.addEventListener(Event.COMPLETE, xmlLoaded); 
		}
		
		private function xmlLoaded(e:Event):void {
			var myXML:XML = XML(myLoader.data); 
			var str:String = myXML.layer.data;
			Resource.MAP = str;
			
			Ax.pushState(new GameState);
		}
		
		override public function create():void {
			Ax.background = AxColor.fromHex(0x95c7e8);
		}
		
	}
	
}