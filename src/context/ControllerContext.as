package context {
	import controller.Controller;
	import controller.FormsController;
	import controller.TetrisEngineController;

	import enums.ControllerType;
	import enums.ModelType;

	import flash.utils.Dictionary;

	import model.SaveModel;

	import model.TetrisEngineModel;

	public class ControllerContext {
		private var _controllers:Dictionary = new Dictionary();

		public function ControllerContext(modelContext:ModelContext) {
			init(modelContext);
		}

		private function init(modelContext:ModelContext):void {
			var tetrisEngineModel:TetrisEngineModel = TetrisEngineModel(modelContext.getModel(ModelType.TETRIS_ENGINE_MODEL));
			var saveModel:SaveModel = SaveModel(modelContext.getModel(ModelType.SAVE_MODEL));

			_controllers[ControllerType.FORMS_CONTROLLER] = new FormsController();
			_controllers[ControllerType.TETRIS_ENGINE_CONTROLLER] = new TetrisEngineController(tetrisEngineModel, saveModel);
		}

		public function getController(type:ControllerType):Controller {
			return _controllers[type];
		}
	}
}
