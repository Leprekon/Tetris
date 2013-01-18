package events {
	public class ApplicationModelEvent extends DataEvent{
		public static const STATE_CHANGED:String = "stateChanged";

		public function ApplicationModelEvent(type:String, data:* = null) {
			super(type, data);
		}
	}
}
