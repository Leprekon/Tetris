package enums {
	import model.Model;

	public class ModelType extends AbstractEnum{
		public static const APPLICATION_MODEL:ModelType = new ModelType("applicationModel");
		public static const MAIN_MENU_MODEL:ModelType = new ModelType("mainMenuModel");
		public static const TETRIS_ENGINE_MODEL:ModelType = new ModelType("tetrisEngineModel");
		public static const SAVE_MODEL:ModelType = new ModelType("saveModel");

		public function ModelType(name:String) {
			super(name);
		}
	}
}
