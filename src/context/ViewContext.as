package context {
	import controller.Controller;
	import controller.FormsController;
	import controller.TetrisEngineController;

	import enums.ControllerType;
	import enums.ModelType;
	import enums.ViewType;

	import flash.utils.Dictionary;

	import model.ApplicationModel;
	import model.SaveModel;
	import model.TetrisEngineModel;

	import view.*;

	public class ViewContext {
		private var _views:Dictionary = new Dictionary();

		public function ViewContext(modelContext:ModelContext, contrContext:ControllerContext) {
			init(modelContext, contrContext);
		}

		private function init(modelContext:ModelContext, controllerContext:ControllerContext):void {
			var applicationModel:ApplicationModel = ApplicationModel(modelContext.getModel(ModelType.APPLICATION_MODEL));
			var tetrisEngineModel:TetrisEngineModel = TetrisEngineModel(modelContext.getModel(ModelType.TETRIS_ENGINE_MODEL));
			var saveModel:SaveModel = SaveModel(modelContext.getModel(ModelType.SAVE_MODEL));

			var formsController:FormsController = FormsController(controllerContext.getController(ControllerType.FORMS_CONTROLLER));
			var tetrisController:TetrisEngineController = TetrisEngineController(controllerContext.getController(ControllerType.TETRIS_ENGINE_CONTROLLER));

			_views[ViewType.MAIN_MENU_VIEW] = new MainMenuView(applicationModel, formsController, saveModel);
			_views[ViewType.GAME_VIEW] = new GameView(applicationModel, formsController, tetrisEngineModel, tetrisController);
		}
	}
}
