package events {

	public class TetrisEngineModelEvent extends DataEvent {
		public static const GAME_OVER:String = "gameOver";
		public static const NEXT_FIGURE_CHANGED:String = "nextFigureChanged";


		public function TetrisEngineModelEvent(type:String, data:* = null) {
			super(type, data);
		}
	}
}
