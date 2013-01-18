package canvas {
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.primitives.Plane;
	import alternativa.engine3d.resources.BitmapTextureResource;

	import engine.Cube;
	import engine.Figure;

	import flash.display.Sprite;
	import flash.display.Stage3D;

	import managers.AssetsManager;

	public class GameCanvas3d extends Canvas3d{
		private static const FIELD_WIDTH:int = Cube3d.SIZE * 10;
		private static const FIELD_HEIGHT:int = Cube3d.SIZE * 20;

		private var _cubes3d:Vector.<Cube3d> = new <Cube3d>[];
		private var _cubesContainer:Object3D;
		private var _background:Plane;

		public function update(cubes:Vector.<Cube>):void {
			deleteMissingCubes(cubes);
			addNewCubes(cubes);
			updateExistingCubes(cubes);
			_camera.render(_stage3d);
		}

		override public function create(width:int, height:int, canvas:Sprite, stage3d:Stage3D):void {
			super.create(width, height, canvas, stage3d);

			_camera.view.antiAlias = 2;
			_camera.view.backgroundColor = 0x2C4D6E;

			_camera.x = FIELD_WIDTH / 2 - Figure.FIGURE_SIZE * 1.25;
			_camera.y = - FIELD_HEIGHT / 2 - Figure.FIGURE_SIZE * 4;
			_camera.z = FIELD_HEIGHT / 2 + Figure.FIGURE_SIZE * 2.5;
//			_camera.orthographic = true;

//			_camera.fov = Math.PI / 4;

			_camera.lookAt(_camera.x, - Figure.FIGURE_SIZE, _camera.z);

			_cubesContainer = new Object3D();
			_rootContainer.addChild(_cubesContainer);

			_background = new Plane(FIELD_WIDTH * 1.3, FIELD_HEIGHT * 1.3);
			_background.x = _camera.x;
			_background.z = _camera.z;
			_background.y = 30;
			_background.rotationX = Math.PI / 2;
			var bitmapTextureResource:BitmapTextureResource = new BitmapTextureResource(new BackgroundAsset());
			bitmapTextureResource.upload(stage3d.context3D);
			_background.geometry.upload(stage3d.context3D);
			_background.setMaterialToAllSurfaces(new TextureMaterial(bitmapTextureResource));
			_rootContainer.addChild(_background);
		}

		private function deleteMissingCubes(cubes:Vector.<Cube>):void {
			var i:int = 0;
			while(i < _cubes3d.length){
				var cube3d:Cube3d = _cubes3d[i];
				var needToDelete:Boolean = true;
				for each(var cube:Cube in cubes) {
					if(cube.id == cube3d.id){
						needToDelete = false;
					}
				}

				if(needToDelete){
					_cubesContainer.removeChild(cube3d.model);
					_cubes3d.splice(i, 1);
				} else {
					i++;
				}
			}
		}

		private function addNewCubes(cubes:Vector.<Cube>):void {
			for each(var cube:Cube in cubes) {
				var isNew:Boolean = true;
				for each(var cube3d:Cube3d in _cubes3d){
					if(cube.id == cube3d.id){
						isNew = false;
						break;
					}
				}
				if(isNew){
					var newCube3d:Cube3d = new Cube3d(cube.id, cube.colorType);
					newCube3d.create(_stage3d.context3D);
					_cubesContainer.addChild(newCube3d.model);
					_cubes3d.push(newCube3d);
				}
			}
		}

		private function updateExistingCubes(cubes:Vector.<Cube>):void {
			for each(var cube:Cube in cubes) {
				for each(var cube3d:Cube3d in _cubes3d){
					if(cube.id == cube3d.id){
						cube3d.model.x = cube.position.x * Cube3d.SIZE;
						cube3d.model.z = cube.position.y * Cube3d.SIZE;
						cube3d.model.y = 0;
					}
				}
			}
		}

		public function reset():void {
			_cubesContainer.removeChildren();
			_cubes3d = new <Cube3d>[];
		}
	}

}
