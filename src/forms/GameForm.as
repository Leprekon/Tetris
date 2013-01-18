package forms {
	import events.UIEvent;

	import flash.display.DisplayObject;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	import forms.Form;

	public class GameForm extends Form{
		private var _asset:TetrisFormAsset;
		private var _gameCanvasContainer:Sprite;
		private var _nextFigureCanvasContainer:Sprite;
		private var _levelField:TextField;
		private var _scoreField:TextField;
		private var _buttonRotate:DisplayObject;
		private var _buttonRight:DisplayObject;
		private var _buttonLeft:DisplayObject;
		private var _buttonDown:DisplayObject;

		public function GameForm() {
			init();
		}

		private function init():void {
			_asset = new TetrisFormAsset();

			addChild(_asset);

			_gameCanvasContainer = new Sprite();
			_gameCanvasContainer.x = _gameCanvasContainer.y = 10;

			_asset.addChild(_gameCanvasContainer);

			_nextFigureCanvasContainer = new Sprite();
			_nextFigureCanvasContainer.x = 335;
			_nextFigureCanvasContainer.y = 70;

			_asset.addChild(_nextFigureCanvasContainer);

			_levelField = TextField(_asset.getChildByName("text_level"));
			_scoreField = TextField(_asset.getChildByName("text_score"));

			_buttonRotate = _asset.getChildByName("button_rotate");
			_buttonRotate.addEventListener(MouseEvent.MOUSE_DOWN, handleRotate);

			_buttonRight = _asset.getChildByName("button_right");
			_buttonRight.addEventListener(MouseEvent.MOUSE_DOWN, handleRight);

			_buttonLeft = _asset.getChildByName("button_left");
			_buttonLeft.addEventListener(MouseEvent.MOUSE_DOWN, handleLeft);

			_buttonDown = _asset.getChildByName("button_down");
			_buttonDown.addEventListener(MouseEvent.MOUSE_DOWN, handleDown);
			_buttonDown.addEventListener(MouseEvent.MOUSE_UP, handleDownOut);
			_buttonDown.addEventListener(MouseEvent.MOUSE_OUT, handleDownOut);
		}

		private function handleDownOut(event:MouseEvent):void {
			dispatchEvent(new UIEvent(UIEvent.STOP_ACCELERATION));
		}

		private function handleKeyDown(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.LEFT){
				dispatchEvent(new UIEvent(UIEvent.LEFT));
			} else if (event.keyCode == Keyboard.RIGHT){
				dispatchEvent(new UIEvent(UIEvent.RIGHT));
			} else if (event.keyCode == Keyboard.UP){
				dispatchEvent(new UIEvent(UIEvent.ROTATE));
			} else if (event.keyCode == Keyboard.DOWN){
				dispatchEvent(new UIEvent(UIEvent.START_ACCELERATION));
			}
		}

		private function handleKeyUp(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.DOWN){
				dispatchEvent(new UIEvent(UIEvent.STOP_ACCELERATION));
			}
		}

		private function handleDown(event:MouseEvent):void {
			dispatchEvent(new UIEvent(UIEvent.START_ACCELERATION));
		}

		private function handleLeft(event:MouseEvent):void {
			dispatchEvent(new UIEvent(UIEvent.LEFT));
		}

		private function handleRight(event:MouseEvent):void {
			dispatchEvent(new UIEvent(UIEvent.RIGHT));
		}

		private function handleRotate(event:MouseEvent):void {
			dispatchEvent(new UIEvent(UIEvent.ROTATE));
		}

		public function getGameCanvasContainer():Sprite {
			return  _gameCanvasContainer;
		}

		public function getNextFigureCanvasContainer():Sprite {
			return _nextFigureCanvasContainer;
		}

		public function setLevel(level:int):void {
			_levelField.text = String(level);
		}

		public function setScore(score:int):void {
			_scoreField.text = String(score);
		}

		override public function show():void {
			super.show();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		}

		override public function hide():void {
			super.hide();
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		}
	}
}
