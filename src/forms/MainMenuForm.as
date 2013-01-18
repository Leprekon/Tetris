package forms {
	import events.UIEvent;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class MainMenuForm extends Form{
		private var _asset:MainMenuFormAsset;
		private var _startButton:DisplayObject;
		private var _highScoreField:TextField;

		public function MainMenuForm() {
			init();
		}

		private function init():void {
			_asset = new MainMenuFormAsset();
			addChild(_asset);

			_startButton = _asset.getChildByName("start_button");
			_startButton.addEventListener(MouseEvent.MOUSE_DOWN, handleClickStart);

			new MainFontAsset();

			_highScoreField = TextField(_asset.getChildByName("highscore_field"));
			_highScoreField.embedFonts = true;
		}

		private function handleClickStart(event:MouseEvent):void {
			dispatchEvent(new UIEvent(UIEvent.START));
		}

		public function configHighscoreVisible(visible:Boolean):void {
			_highScoreField.visible = visible;
		}

		public function setHighscore(highscore:int):void {
			_highScoreField.text = "HIGHSCORE \n"  + String(highscore);
		}
	}
}
