package model {
	import events.SaveModelEvent;

	import flash.net.SharedObject;

	public class SaveModel extends Model{
		private var _sharedObject:SharedObject;
		private var _highscore:int = 0;

		public function SaveModel() {
			init();
		}

		private function init():void {
			_sharedObject = SharedObject.getLocal("TetrisData");

			if(_sharedObject.data.highscore != null) {
				_highscore = _sharedObject.data.highscore;
			}
		}

		public function isHighscoreAvailable():Boolean {
			return _highscore > 0;
		}

		public function getHighscore():int {
			return _highscore;
		}

		public function saveHighscore(value:int):void {
			_highscore = value;
			_sharedObject.data.highscore = _highscore;
			_sharedObject.flush();
			dispatchEvent(new SaveModelEvent(SaveModelEvent.HIGHSCORE_CHANGED));
		}
	}
}
