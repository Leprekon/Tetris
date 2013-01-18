package utils {
	public class TimeConverter {
		public function TimeConverter() {
		}

		public static function fromSeconds(seconds:int):int {
			return seconds * 1000;
		}
	}
}
