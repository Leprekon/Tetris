package controller {
	import events.TetrisEngineModelEvent;

	import model.SaveModel;
	import model.TetrisEngineModel;

	public class TetrisEngineController extends Controller{
		private var _tetrisEngineModel:TetrisEngineModel;
		private var _saveModel:SaveModel;

		public function TetrisEngineController(tetrisEngineModel:TetrisEngineModel, saveModel:SaveModel) {
			_tetrisEngineModel = tetrisEngineModel;
			_saveModel = saveModel;

			init();
		}

		private function init():void {
			_tetrisEngineModel.addEventListener(TetrisEngineModelEvent.GAME_OVER, handleGameOver);
		}

		private function handleGameOver(event:TetrisEngineModelEvent):void {
			var score:int = _tetrisEngineModel.getScore();
			var highscore:int = _saveModel.getHighscore();
			if(score > highscore){
				_saveModel.saveHighscore(score);
			}
		}
	}
}
