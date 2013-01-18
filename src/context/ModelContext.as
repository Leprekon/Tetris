package context {
	import model.*;
	import enums.ModelType;

	import flash.utils.Dictionary;

	public class ModelContext {
		private var _models:Dictionary = new Dictionary();

		public function ModelContext() {
			init();
		}

		private function init():void {
			_models[ModelType.APPLICATION_MODEL] = new ApplicationModel();
			_models[ModelType.TETRIS_ENGINE_MODEL] = new TetrisEngineModel();
			_models[ModelType.SAVE_MODEL] = new SaveModel();
		}

		public function getModel(type:ModelType):Model {
			return _models[type];
		}
	}
}
