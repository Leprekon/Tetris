package model {
	import engine.Cube;
	import engine.Figure;

	import events.TetrisEngineModelEvent;

	import flash.geom.Point;
	import flash.utils.ByteArray;

	import flash.utils.getTimer;

	import utils.TimeConverter;

	public class TetrisEngineModel extends Model{
		public static const FIELD_WIDTH:int = 10;
		public static const FIELD_HEIGHT:int = 20 + Figure.FIGURE_SIZE;
		public static const START_SPEED:int = 2;
		public static const MAX_SPEED:int = 14;

		[Embed(source="../engine/figure_types.xml", mimeType="application/octet-stream")]
		private static const _figuresConfigClass:Class;

		private var _field:Vector.<Vector.<Cube>>;
		private var _possibleFigures:Vector.<Figure>;
		private var _lastUpdateTime:int;
		private var _nextFigure:Figure;
		private var _currentFigure:Figure;

		private var _speed:Number;
		private var _figureIDCounter:int = 0;
		private var _cubeIDCounter:int = 0;
		private var _score:int;
		private var _isRunning:Boolean;

		private var _isAccelerated:Boolean = false;
		private var _level:int;
		private var _linesBracked:int;

		public function TetrisEngineModel() {
			init();
		}

		private function init():void {
			createPossibleFigures();
		}

		private function resetField():void {
			_field = new Vector.<Vector.<Cube>>(FIELD_HEIGHT);
			for (var i:int = 0; i < FIELD_HEIGHT; i++) {
				_field[i] = new Vector.<Cube>(FIELD_WIDTH);
			}
		}

		private function createPossibleFigures():void {
			var byteArray:ByteArray = new _figuresConfigClass();
			var figuresConfig:XML = new XML(byteArray.readUTFBytes(byteArray.length));

			_possibleFigures = new Vector.<Figure>();
			for each(var figureConfig:XML in figuresConfig.figure){
				var figure:Figure = new Figure();
				figure.createFromXML(figureConfig);
				_possibleFigures.push(figure);
			}
		}

		public function start():void {
			_isRunning = true;
			resetField();
			_cubeIDCounter = 0;
			_figureIDCounter = 0;
			_score = 0;
			_linesBracked = 0;
			_level = 1;
			_speed = START_SPEED;
			_isAccelerated = false;
			_lastUpdateTime = getTimer();
			dropFigure(getRandomFigure());
			updateNextFigure();
		}

		public function stop():void {
			_isRunning = false;
		}

		private function updateNextFigure():void {
			_nextFigure = getRandomFigure();
			dispatchEvent(new TetrisEngineModelEvent(TetrisEngineModelEvent.NEXT_FIGURE_CHANGED));
		}

		private function getRandomFigure():Figure {
			var figure:Figure = _possibleFigures[Math.floor(Math.random() * _possibleFigures.length)].clone();
			figure.id = _figureIDCounter;
			_figureIDCounter ++;
			for(var i:int = 0; i < Figure.FIGURE_SIZE; i++){
				for(var j:int = 0; j < Figure.FIGURE_SIZE; j++){
					var cube:Cube = figure.getCubeAt(i, j);
					if(cube != null){
						cube.id = _cubeIDCounter;
						_cubeIDCounter ++;
					}
				}
			}
			return figure;
		}

		private function dropFigure(figure:Figure):void {
			_currentFigure = figure;
			_currentFigure.position.x = FIELD_WIDTH / 2 - Figure.FIGURE_SIZE / 2;
			_currentFigure.position.y = FIELD_HEIGHT - Figure.FIGURE_SIZE + 1;

			updateFigureCubesPositions(_currentFigure);
		}

		private function updateFigureCubesPositions(figure:Figure):void {
			for(var localI:int = 0; localI < Figure.FIGURE_SIZE; localI++){
				for(var localJ:int = 0; localJ < Figure.FIGURE_SIZE; localJ++){
					var cube:Cube = figure.getCubeAt(localI, localJ);
					if(cube != null){
						cube.position.y = figure.position.y + localI;
						cube.position.x = figure.position.x + localJ;
					}
				}
			}
		}

		public function update():void {
			var curTime:int = getTimer();
			if(_isRunning){
				var elapsedTime:int = curTime - _lastUpdateTime;
				if(elapsedTime < 100){
					var speed:Number = _isAccelerated ? MAX_SPEED : _speed;
					var distanceTravelled:Number = speed * elapsedTime /TimeConverter.fromSeconds(1);
					if(isCanMoveFigure(_currentFigure, distanceTravelled)){
						moveCurrentFigure(distanceTravelled);
					} else {
						stopCurrentFigure();
						checkLinesBreaked();
						dropFigure(_nextFigure);
						updateNextFigure();
					}
				} else {
					trace("Too much lag, cant keep up");
				}
			}
			_lastUpdateTime = curTime;
		}

		private function checkLinesBreaked():void {
			var needCheck:Boolean = true;
			var scoreForLine:int = 1;
			while(needCheck){
				needCheck = false;
				for (var i:int = 0; i < FIELD_HEIGHT; i++){
					var isLineSolid:Boolean = true;
					for(var j:int = 0; j < FIELD_WIDTH; j++){
						if(_field[i][j] == null){
							isLineSolid = false;
							break;
						}
					}
					if(isLineSolid){
						needCheck = true;
						breakLine(i);
						_score += scoreForLine;
						scoreForLine *= 2;
						_linesBracked ++;
						if(_linesBracked % 5 == 0 && _speed < MAX_SPEED){
							_speed += 1;
							_level ++;
						}
						break;
					}
				}
			}
		}

		private function breakLine(lineI:int):void {
			var newField:Vector.<Vector.<Cube>> = new Vector.<Vector.<Cube>>(FIELD_HEIGHT);
			var sourceI:int = 0;
			for (var i:int = 0; i < FIELD_HEIGHT; i++) {
				if(i == lineI){
					sourceI ++;
				}
				newField[i] = new Vector.<Cube>(FIELD_WIDTH);
				for(var j:int = 0; j < FIELD_WIDTH; j++){
					if(sourceI < FIELD_HEIGHT){
						var cube:Cube = _field[sourceI][j];
						newField[i][j] = cube;
						if(cube != null){
							cube.position.y = i;
						}
					} else {
						newField[i][j] = null;
					}
				}
				sourceI ++;
			}

			_field = newField;
		}

		private function stopCurrentFigure():void {
			for(var localI:int = 0; localI < Figure.FIGURE_SIZE; localI++){
				for(var localJ:int = 0; localJ < Figure.FIGURE_SIZE; localJ++){
					var cube:Cube = _currentFigure.getCubeAt(localI, localJ);
					if(cube != null){
						var realJ:int = Math.round(cube.position.x);
						var realI:int = Math.round(cube.position.y);
						cube.position.x = realJ;
						cube.position.y = realI;
						_field[realI][realJ] = cube;

						if(realI > FIELD_HEIGHT - Figure.FIGURE_SIZE){
							dispatchEvent(new TetrisEngineModelEvent(TetrisEngineModelEvent.GAME_OVER));
						}
					}
				}
			}
		}

		private function isCanMoveFigure(figure:Figure, distance:Number):Boolean {
			var clone:Figure = figure.clone();
			clone.position.y -= distance;
			return checkFigurePossible(clone);
		}

		private function checkFigurePossible(figure:Figure):Boolean {
			var isPossible:Boolean = true;
			for (var localI:int = 0; localI < Figure.FIGURE_SIZE; localI++) {
				for (var localJ:int = 0; localJ < Figure.FIGURE_SIZE; localJ++) {
					var cube:Cube = figure.getCubeAt(localI, localJ);
					if (cube != null) {
						var realJ:int = Math.floor(cube.position.x);
						var realI:int = Math.floor(cube.position.y);
						var realCube:Cube = getCube(realI, realJ);
						if (realCube != null || realI <= 0 || realJ < 0 || realJ >= FIELD_WIDTH) {
							isPossible = false;
							break;
						}
					}
				}
			}
			return isPossible;
		}

		private function moveCurrentFigure(distance:Number):void {
			_currentFigure.position.y -= distance;
			updateFigureCubesPositions(_currentFigure);
		}

		private function getCube(i:int, j:int):Cube {
			var result:Cube;
			if(i >= 0 && j >= 0 && i < FIELD_HEIGHT && j < FIELD_WIDTH){
				result = _field[i][j];
			}
			return result;
		}

		public function rotate():void {
			if(isClockWiseRotationPossible()){
				rotateClockWise();
			} else if (isCounterClockWiseRotationPossible()){
				rotateCounterClockWise();
			}
		}

		private function rotateCounterClockWise():void {
			_currentFigure = _currentFigure.getCounterClockWiseRotation();
			updateFigureCubesPositions(_currentFigure);
		}

		private function isCounterClockWiseRotationPossible():Boolean {
			var rotatedFigure:Figure = _currentFigure.getCounterClockWiseRotation();
			updateFigureCubesPositions(rotatedFigure);
			return checkFigurePossible(rotatedFigure);
		}

		private function rotateClockWise():void {
			_currentFigure = _currentFigure.getClockWiseRotation();
			updateFigureCubesPositions(_currentFigure);
		}

		private function isClockWiseRotationPossible():Boolean {
			var rotatedFigure:Figure = _currentFigure.getClockWiseRotation();
			updateFigureCubesPositions(rotatedFigure);
			return checkFigurePossible(rotatedFigure);
		}

		public function moveLeft():void {
			var clone:Figure = _currentFigure.clone();
			clone.position.x--;
			updateFigureCubesPositions(clone);
			if(checkFigurePossible(clone)){
				_currentFigure.position.x --;
				updateFigureCubesPositions(_currentFigure);
			}
		}

		public function moveRight():void {
			var clone:Figure = _currentFigure.clone();
			clone.position.x++;
			updateFigureCubesPositions(clone);
			if(checkFigurePossible(clone)){
				_currentFigure.position.x ++;
				updateFigureCubesPositions(_currentFigure);
			}
		}

		public function startAcceleration():void {
			_isAccelerated = true;
		}

		public function stopAcceleration():void {
			_isAccelerated = false;
		}

		public function getAllCubesVector():Vector.<Cube> {
			return getFieldCubesVector().concat(getCurrentFigureCubesVector());
		}

		private function getFieldCubesVector():Vector.<Cube> {
			var result:Vector.<Cube> = new <Cube>[];
			for (var i:int = 0; i < FIELD_HEIGHT; i++) {
				for (var j:int = 0; j < FIELD_WIDTH; j++) {
					if(_field[i][j] != null){
						result.push(_field[i][j]);
					}
				}
			}
			return result;
		}

		private function getCurrentFigureCubesVector():Vector.<Cube> {
			var result:Vector.<Cube> = new <Cube>[];
			for (var i:int = 0; i < Figure.FIGURE_SIZE; i++) {
				for (var j:int = 0; j < Figure.FIGURE_SIZE; j++) {
					var cube:Cube = _currentFigure.getCubeAt(i,j);
					if(cube != null){
						result.push(cube);
					}
				}
			}
			return result;
		}

		public function getScore():int {
			return _score;
		}

		public function getLevel():int {
			return _level;
		}

		public function getNextFigure():Figure {
			return _nextFigure;
		}
	}
}
