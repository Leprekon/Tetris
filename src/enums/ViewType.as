package enums {
	public class ViewType extends AbstractEnum{
		public static const MAIN_MENU_VIEW:ViewType = new ViewType("mainMenuView");
		public static const GAME_VIEW:ViewType = new ViewType("gameView");

		public function ViewType(name:String) {
			super(name);
		}
	}
}
