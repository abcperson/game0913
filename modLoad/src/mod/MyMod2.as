package mod {
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	//import flash.events.MouseEvent;
	
	/**
	* @mxmlc -debug=true -o=bin/mod/MyMod.swf -load-externs=linkreport.xml -source-path=src -noplay
	*/
	
	/**
	 * ...
	 * @author TJJTDS
	 */
	[ExcludeClass]
	public class MyMod2 extends Sprite {
		
		public function MyMod2() {
			//addChild(new GameLib.testB());
			//this.buttonMode = true;
			//this.mouseChildren = true;
			//this.mouseEnabled = true;
			//addEventListener(MouseEvent.CLICK, onMouseClick);
			//trace("My Mod build");
			
			//var content:Sprite = new Sprite();
			//addChild(content);
			//content.addChild(new GameLib.testB());
			//content.buttonMode = true;
			//content.mouseChildren = true;
			//content.mouseEnabled = true;
			//
			//content.addEventListener(MouseEvent.CLICK, onMouseClick);
			
			//MyMod
		}
		
		//private function onMouseClick(e:MouseEvent):void {
			//trace("click MyMod");
		//}
		
		public function makeClass():Class {
			return ApplicationDomain.currentDomain.getDefinition("mod.MyMod") as Class;
		}
	}
}