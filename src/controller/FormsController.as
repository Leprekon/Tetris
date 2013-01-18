package controller {
	import forms.Form;

	public class FormsController extends Controller{
		private var _canvas:Main;
		private var _currentForm:Form;

		public function FormsController() {
		}

		public function setCanvas(sprite:Main):void {
			_canvas = sprite;
		}

		public function showForm(form:Form):void {
			hideForm();
			_currentForm = form;
			_canvas.addChild(form);
			_currentForm.show();
		}

		private function hideForm():void {
			if(_currentForm != null){
				_currentForm.hide();
				_canvas.removeChild(_currentForm);
			}
		}
	}
}
