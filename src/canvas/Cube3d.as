package canvas {
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.primitives.Box;
	import alternativa.engine3d.resources.BitmapTextureResource;

	import enums.CubeColorType;

	import flash.display.BitmapData;

	import flash.display.MovieClip;

	import flash.display3D.Context3D;

	import managers.AssetsManager;

	public class Cube3d {
		public static const SIZE:Number = 10;

		private var _id:int;
		private var _model:Mesh;
		private var _color:CubeColorType;

		public function Cube3d(id:int, color:CubeColorType) {
			_id = id;
			_color = color;
		}

		public function create(context3d:Context3D):void {
			_model = AssetsManager.getInstance().getCubeMesh();
			_model.geometry.upload(context3d);

			var asset:MovieClip = new BlockTextureAsset();
			asset.gotoAndStop(_color.assetFrame);

			var bitmapData:BitmapData = new BitmapData(asset.width, asset.height);
			bitmapData.draw(asset);

			var bitmapTextureResource:BitmapTextureResource = new BitmapTextureResource(bitmapData);
			bitmapTextureResource.upload(context3d);
			var textureMaterial:TextureMaterial = new TextureMaterial(bitmapTextureResource);
			_model.setMaterialToAllSurfaces(textureMaterial);
		}

		public function get id():int {
			return _id;
		}

		public function set id(value:int):void {
			_id = value;
		}

		public function get model():Object3D {
			return _model;
		}
	}
}
