package enums {
	public class CubeColorType extends AbstractEnum{
		public static var _allTypes:Vector.<CubeColorType> = new <CubeColorType>[];

		public static const CYAN:CubeColorType = new CubeColorType("cyan", 5);
		public static const BLUE:CubeColorType = new CubeColorType("blue", 6);
		public static const ORANGE:CubeColorType = new CubeColorType("orange", 2);
		public static const YELLOW:CubeColorType = new CubeColorType("yellow", 3);
		public static const GREEN:CubeColorType = new CubeColorType("green", 4);
		public static const PURPLE:CubeColorType = new CubeColorType("purple", 7);
		public static const RED:CubeColorType = new CubeColorType("red", 1);

		private var _assetFrame:int;

		public function CubeColorType(name:String, assetFrame:int) {
			super(name);
			_assetFrame = assetFrame;

			_allTypes.push(this);
		}

		public static function getTypeByName(name:String):CubeColorType {
			var result:CubeColorType;
			for each(var colorType:CubeColorType in _allTypes){
				if(colorType.name == name) {
					result = colorType;
					break;
				}
			}
			return result;
		}

		public function get assetFrame():int {
			return _assetFrame;
		}
	}
}
