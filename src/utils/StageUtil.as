package utils {
	import flash.display.Stage3D;

	public class StageUtil {
		private static var _stage3Ds:Vector.<Stage3D>;

		public function StageUtil() {
		}

		public static function init(stage3Ds:Vector.<Stage3D>):void {
			_stage3Ds = stage3Ds;
		}

		public static function get stage3D():Vector.<Stage3D> {
			return _stage3Ds;
		}
	}
}
