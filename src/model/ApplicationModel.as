package model {
	import enums.ApplicationState;

	import events.ApplicationModelEvent;

	public class ApplicationModel extends Model{
		private var _state:ApplicationState;

		public function ApplicationModel() {
		}


		public function set state(value:ApplicationState):void {
			if(value != _state){
				_state = value;
				dispatchEvent(new ApplicationModelEvent(ApplicationModelEvent.STATE_CHANGED, _state));
			}
		}

		public function get state():ApplicationState {
			return _state;
		}
	}
}
