package view {
	import controller.FormsController;

	import enums.ApplicationState;

	import events.ApplicationModelEvent;
	import events.SaveModelEvent;
	import events.UIEvent;

	import forms.MainMenuForm;

	import model.ApplicationModel;
	import model.SaveModel;

	public class MainMenuView extends View{
		private var _applicationModel:ApplicationModel;
		private var _formsController:FormsController;
		private var _mainMenuForm:MainMenuForm;
		private var _saveModel:SaveModel;

		public function MainMenuView(applicationModel:ApplicationModel, formsController:FormsController, saveModel:SaveModel) {
			_applicationModel = applicationModel;
			_formsController = formsController;
			_saveModel = saveModel;

			init();
		}

		private function init():void {
			_applicationModel.addEventListener(ApplicationModelEvent.STATE_CHANGED, handleApplicationStateChanged);

			_saveModel.addEventListener(SaveModelEvent.HIGHSCORE_CHANGED, handleHighscoreChanged);

			_mainMenuForm = new MainMenuForm();
			_mainMenuForm.addEventListener(UIEvent.START, handleStart);
		}

		private function handleHighscoreChanged(event:SaveModelEvent):void {
			updateHighscore();
		}

		private function handleStart(event:UIEvent):void {
			_applicationModel.state = ApplicationState.GAME;
		}

		private function handleApplicationStateChanged(event:ApplicationModelEvent):void {
			if(_applicationModel.state == ApplicationState.MAIN_MENU){
				_formsController.showForm(_mainMenuForm);
				updateHighscore();
			}
		}

		private function updateHighscore():void {
			_mainMenuForm.configHighscoreVisible(_saveModel.isHighscoreAvailable());
			_mainMenuForm.setHighscore(_saveModel.getHighscore());
		}
	}
}
