package enums {
	public class AbstractEnum {
		private var _name:String;
		public function AbstractEnum(name:String) {
			_name = name;
		}

		public function get name():String {
			return _name;
		}
	}
}
