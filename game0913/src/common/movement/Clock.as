package common.movement {
	import flash.utils.getTimer;
	/**
	 * 理论上可以用来获取服务器时间
	 * @author TJJTDS
	 */
	public class Clock {
		
		public function Clock() {
			
		}
		
		/**
		 * The best approximation of the time on the server
		 * 最接近服务器的时间
		 */
		public function get time():int {
			var now:int = getTimer();
			return now;
		}
	}

}