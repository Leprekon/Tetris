package events {
	public class SaveModelEvent extends DataEvent {
		public static const HIGHSCORE_CHANGED:String = "highscoreChanged";

		public function SaveModelEvent(type:String, data:* = null) {
			super(type, data);
		}
	}
}
