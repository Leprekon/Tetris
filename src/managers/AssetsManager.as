package managers {
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.loaders.ParserA3D;
	import alternativa.engine3d.objects.Mesh;

	import errors.SingletonError;

	public class AssetsManager {
		private static var _allowInstantiation:Boolean = false;
		private static var _instance:AssetsManager;

		[Embed(source="../../lib/box.A3D", mimeType="application/octet-stream")]
		private var _cubeModelClass:Class;

		private var _cubeMesh:Mesh;

		public function AssetsManager() {
			if(!_allowInstantiation){
				throw new SingletonError();
			}
		}

		public static function getInstance():AssetsManager {
			if(_instance == null){
				_allowInstantiation = true;
				_instance = new AssetsManager();
				_allowInstantiation = false;
			}

			return _instance;
		}

		public function getCubeMesh():Mesh {
			if(_cubeMesh == null){
				var parserA3d:ParserA3D = new ParserA3D();
				parserA3d.parse(new _cubeModelClass());

				for each(var object3d:Object3D in parserA3d.objects){
					if(object3d is Mesh){
						_cubeMesh = Mesh(object3d);
						break;
					}
				}
			}

			var mesh:Mesh = Mesh(_cubeMesh.clone());
			return mesh;
		}
	}
}
