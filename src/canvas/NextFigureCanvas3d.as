package canvas {
	import alternativa.engine3d.controllers.SimpleObjectController;
	import alternativa.engine3d.core.Object3D;

	import engine.Cube;
	import engine.Figure;

	import flash.display.Sprite;
	import flash.display.Stage3D;

	import managers.AssetsManager;

	import utils.StageUtil;

	public class NextFigureCanvas3d extends Canvas3d{
		private var _cubesContainer:Object3D;

		override public function create(width:int, height:int, canvas:Sprite, stage3d:Stage3D):void {
			super.create(width, height, canvas, stage3d);

			_camera.view.antiAlias = 2;
			_camera.view.backgroundColor = 0x2C4D6E;

			_camera.x = Figure.FIGURE_SIZE * Cube3d.SIZE / 2 - Cube3d.SIZE /2;
			_camera.y = - 40;
			_camera.z = Figure.FIGURE_SIZE * Cube3d.SIZE / 2 - Cube3d.SIZE /2;
//			_camera.orthographic = true;

//			_camera.fov = Math.PI / 4;

			_camera.lookAt(_camera.x, 0, _camera.z);

			_cubesContainer = new Object3D();
			_rootContainer.addChild(_cubesContainer);
		}

		public function update():void {
			_camera.render(_stage3d);
		}

		public function setFigure(figure:Figure):void {
			_cubesContainer.removeChildren();

			for(var i:int = 0; i < Figure.FIGURE_SIZE; i++){
				for(var j:int = 0; j < Figure.FIGURE_SIZE; j++){
					var cube:Cube = figure.getCubeAt(i, j);
					if(cube != null){
						var cube3d:Cube3d = new Cube3d(0, cube.colorType);
						cube3d.create(_stage3d.context3D);
						_cubesContainer.addChild(cube3d.model);

						cube3d.model.x = j * Cube3d.SIZE;
						cube3d.model.z = i * Cube3d.SIZE;
					}
				}
			}
		}

		public function reset():void {
			_cubesContainer.removeChildren();
		}
	}

}
