package engine {
	import enums.CubeColorType;

	import flash.geom.Point;

	public class Figure {
		public static const FIGURE_SIZE:int = 4;
		private var _cubes:Vector.<Vector.<Cube>>;
		private var _position:Point = new Point();
		private var _id:int;

		public function Figure() {
			init();
		}

		private function init():void {
			_cubes = new Vector.<Vector.<Cube>>(FIGURE_SIZE);
			for(var i:int = 0; i < FIGURE_SIZE; i++){
				_cubes[i] = new <Cube>[];
			}
		}

		public function createFromXML(config:XML):void {
			var colorType:CubeColorType = CubeColorType.getTypeByName(config.@color[0]);
			for(var i:int = 0; i < FIGURE_SIZE; i++){
				var rowMask:String = config.row[i].@mask[0];

				for(var j:int = 0; j < FIGURE_SIZE; j++){
					if(rowMask.charAt(j) == "1"){
						_cubes[i][j] = new Cube(colorType);
					} else {
						_cubes[i][j] = null;
					}
				}
			}
		}

		public function clone():Figure {
			var result:Figure = new Figure();
			result.create(_cubes);

			result.id = _id;
			result.position = _position.clone();

			return result;
		}

		public function create(cubes:Vector.<Vector.<Cube>>):void {
			for(var i:int = 0; i < FIGURE_SIZE; i++){
				for(var j:int = 0; j < FIGURE_SIZE; j++){
					if(cubes[i][j] != null){
						_cubes[i][j] = cubes[i][j].clone();
					} else {
						_cubes[i][j] = null;
					}
				}
			}
		}

		public function get position():Point {
			return _position;
		}

		public function set position(value:Point):void {
			_position = value;
		}

		public function getCubeAt(i:int, j:int):Cube {
			return _cubes[i][j];
		}

		public function set id(id:int):void {
			_id = id;
		}

		public function get id():int {
			return _id;
		}

		public function getClockWiseRotation():Figure {
			var rotatedFigure:Figure = new Figure();
			var rotatedCubes:Vector.<Vector.<Cube>> = new Vector.<Vector.<Cube>>(FIGURE_SIZE);
			for(var k:int = 0; k < FIGURE_SIZE; k++){
				rotatedCubes[k] = new Vector.<Cube>(FIGURE_SIZE);
			}
			for(var i:int = 0; i < FIGURE_SIZE; i++){
				for(var j:int = 0; j < FIGURE_SIZE; j ++){
					if(_cubes[i][j] != null){
						rotatedCubes[j][FIGURE_SIZE - i - 1] = _cubes[i][j].clone();
					} else {
						rotatedCubes[j][FIGURE_SIZE - i - 1] = null;
					}
				}
			}
			rotatedFigure.create(rotatedCubes);
			rotatedFigure.position = _position.clone();

			return rotatedFigure;
		}

		public function getCounterClockWiseRotation():Figure {
			var rotatedFigure:Figure = new Figure();
			var rotatedCubes:Vector.<Vector.<Cube>> = new Vector.<Vector.<Cube>>(FIGURE_SIZE);
			for(var k:int = 0; k < FIGURE_SIZE; k++){
				rotatedCubes[k] = new Vector.<Cube>(FIGURE_SIZE);
			}

			for(var i:int = 0; i < FIGURE_SIZE; i++){
				for(var j:int = 0; j < FIGURE_SIZE; j ++){
					if(_cubes[i][j] != null){
						rotatedCubes[FIGURE_SIZE - j - 1][i] = _cubes[i][j].clone();
					} else {
						rotatedCubes[FIGURE_SIZE - j - 1][i] = null;
					}
				}
			}
			rotatedFigure.create(rotatedCubes);
			rotatedFigure.position = _position.clone();

			return rotatedFigure;
		}
	}
}
