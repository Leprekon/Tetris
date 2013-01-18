package enums {
	public class ControllerType extends AbstractEnum{
		public static const FORMS_CONTROLLER:ControllerType = new ControllerType("formsController");
		public static const TETRIS_ENGINE_CONTROLLER:ControllerType = new ControllerType("tetrisEngineController");

		public function ControllerType(name:String) {
			super(name);
		}
	}
}
