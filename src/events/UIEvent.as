package events {
	public class UIEvent extends DataEvent{
		public static const START:String = "start";
		public static const START_ACCELERATION:String = "startAcceleration";
		public static const STOP_ACCELERATION:String = "stopAcceleration";
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const ROTATE:String = "rotate";

		public function UIEvent(type:String, data:* = null) {
			super(type, data);
		}
	}
}
