package events {
	import flash.events.Event;

	public class DataEvent extends Event {
		public function DataEvent(type:String, data:* = null) {
			super(type, data)
		}
	}
}
