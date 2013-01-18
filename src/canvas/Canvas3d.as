package canvas {
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.View;

	import flash.display.Sprite;
	import flash.display.Stage3D;

	public class Canvas3d {
		protected var _rootContainer:Object3D;
		protected var _camera:Camera3D;
		protected var _stage3d:Stage3D;

		public function Canvas3d() {
			init();
		}

		private function init():void {
			_rootContainer = new Object3D();
			_camera = new Camera3D(1, 1000);
			_rootContainer.addChild(_camera);
		}

		public function create(width:int, height:int, canvasContainer:Sprite, stage3d:Stage3D):void {
			_camera.view = new View(width, height);
			_camera.view.hideLogo();
			_stage3d = stage3d;
			canvasContainer.addChild(_camera.view);
		}
	}
}
