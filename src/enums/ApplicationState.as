package enums {
	public class ApplicationState extends AbstractEnum{
		public static const MAIN_MENU:ApplicationState = new ApplicationState("mainMenu");
		public static const GAME:ApplicationState = new ApplicationState("game");
		public static const CREDITS:ApplicationState = new ApplicationState("credits");

		public function ApplicationState(name:String) {
			super(name);
		}
	}
}
