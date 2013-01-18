package engine {
	import enums.CubeColorType;

	import flash.geom.Point;

	public class Cube {
		private var _colorType:CubeColorType;
		private var _position:Point = new Point();
		private var _id:int;

		public function Cube(colorType:CubeColorType) {
			_colorType = colorType;
		}

		public function get colorType():CubeColorType {
			return _colorType;
		}

		public function get position():Point {
			return _position;
		}

		public function set position(value:Point):void {
			_position = value;
		}

		public function clone():Cube {
			var cube:Cube = new Cube(_colorType);
			cube.position = _position.clone();
			cube.id = _id;
			return cube;
		}

		public function set id(id:int):void {
			_id = id;
		}

		public function get id():int {
			return _id;
		}
	}
}
