package view {
	import alternativa.engine3d.core.Object3D;

	import canvas.GameCanvas3d;
	import canvas.NextFigureCanvas3d;

	import engine.Cube;
	import engine.Figure;

	import events.TetrisEngineModelEvent;

	import events.UIEvent;

	import flash.events.Event;
	import flash.utils.setTimeout;

	import forms.GameForm;

	import controller.FormsController;
	import controller.TetrisEngineController;

	import enums.ApplicationState;

	import events.ApplicationModelEvent;

	import model.ApplicationModel;
	import model.TetrisEngineModel;

	import utils.StageUtil;

	public class GameView extends View{
		private var _applicationModel:ApplicationModel;
		private var _formsController:FormsController;
		private var _tetrisEngineModel:TetrisEngineModel;
		private var _tetrisController:TetrisEngineController;
		private var _gameForm:GameForm;
		private var _gameCanvas3d:GameCanvas3d;
		private var _nextFigureCanvas3d:NextFigureCanvas3d;

		public function GameView(applicationModel:ApplicationModel, formsController:FormsController, tetrisEngineModel:TetrisEngineModel, tetrisController:TetrisEngineController) {
			_applicationModel = applicationModel;
			_formsController = formsController;
			_tetrisEngineModel = tetrisEngineModel;
			_tetrisController = tetrisController;

			init();
		}

		private function init():void {
			_applicationModel.addEventListener(ApplicationModelEvent.STATE_CHANGED, handleApplicationStateChanged);

			_tetrisEngineModel.addEventListener(TetrisEngineModelEvent.GAME_OVER, handleGameOver);
			_tetrisEngineModel.addEventListener(TetrisEngineModelEvent.NEXT_FIGURE_CHANGED, handleNextFigureChanged);

			_gameForm = new GameForm();
			_gameForm.addEventListener(UIEvent.START_ACCELERATION, handleStartAcceleration);
			_gameForm.addEventListener(UIEvent.STOP_ACCELERATION, handleStopAcceleration);
			_gameForm.addEventListener(UIEvent.RIGHT, handleRight);
			_gameForm.addEventListener(UIEvent.LEFT, handleLeft);
			_gameForm.addEventListener(UIEvent.ROTATE, handleRotate);

			_gameCanvas3d = new GameCanvas3d();
			_gameCanvas3d.create(300, 600, _gameForm.getGameCanvasContainer(), StageUtil.stage3D[0]);

			_nextFigureCanvas3d = new NextFigureCanvas3d();
			_nextFigureCanvas3d.create(120, 150, _gameForm.getNextFigureCanvasContainer(), StageUtil.stage3D[1]);
		}

		private function handleNextFigureChanged(event:TetrisEngineModelEvent):void {
			_nextFigureCanvas3d.setFigure(_tetrisEngineModel.getNextFigure());
			_nextFigureCanvas3d.update();
		}

		private function handleGameOver(event:TetrisEngineModelEvent):void {
			_applicationModel.state = ApplicationState.MAIN_MENU;
		}

		private function handleRotate(event:UIEvent):void {
			_tetrisEngineModel.rotate();
		}

		private function handleLeft(event:UIEvent):void {
			_tetrisEngineModel.moveLeft();
		}

		private function handleRight(event:UIEvent):void {
			_tetrisEngineModel.moveRight();
		}

		private function handleStartAcceleration(event:UIEvent):void {
			_tetrisEngineModel.startAcceleration();
		}

		private function handleStopAcceleration(event:UIEvent):void {
			_tetrisEngineModel.stopAcceleration();
		}

		private function handleApplicationStateChanged(event:ApplicationModelEvent):void {
			if(_applicationModel.state == ApplicationState.GAME){
				start();
			} else {
				stop();
			}
		}

		private function stop():void {
			_tetrisEngineModel.stop();
			_gameForm.removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}

		private function start():void {
			_gameCanvas3d.reset();
			_nextFigureCanvas3d.reset();
			_formsController.showForm(_gameForm);
			_gameForm.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			_tetrisEngineModel.start();
			_nextFigureCanvas3d.setFigure(_tetrisEngineModel.getNextFigure());
		}

		private function handleEnterFrame(event:Event):void {
			_tetrisEngineModel.update();
			_gameCanvas3d.update(_tetrisEngineModel.getAllCubesVector());
			_gameForm.setScore(_tetrisEngineModel.getScore());
			_gameForm.setLevel(_tetrisEngineModel.getLevel());
		}
	}
}
