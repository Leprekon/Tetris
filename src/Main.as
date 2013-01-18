package {
	import context.ControllerContext;
	import context.ModelContext;
	import context.ViewContext;

	import controller.FormsController;

	import enums.ApplicationState;

	import enums.ControllerType;
	import enums.ModelType;

	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import model.ApplicationModel;

	import model.Model;

	import utils.StageUtil;

	[SWF(width="480", height="620", frameRate="60", backgroundColor="#000000")]
	public class Main extends Sprite{
		private var _viewContext:ViewContext;
		private var _modelContext:ModelContext;
		private var _controllerContext:ControllerContext;

		public function Main() {
			init();
		}

		private function init():void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			var stage3D:Stage3D = stage.stage3Ds[0];
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, handleContext3dCreated);
			stage3D.requestContext3D();
		}

		private function handleContext3dCreated(event:Event):void {
			stage.stage3Ds[0].removeEventListener(Event.CONTEXT3D_CREATE, handleContext3dCreated);

			var stage3D:Stage3D = stage.stage3Ds[1];
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, handleSecondContext3dCreated);
			stage3D.requestContext3D();
		}

		private function handleSecondContext3dCreated(event:Event):void {
			stage.stage3Ds[1].removeEventListener(Event.CONTEXT3D_CREATE, handleSecondContext3dCreated);

			StageUtil.init(stage.stage3Ds);

			createMVC();
			start();
		}

		private function start():void {
			var applicationModel:ApplicationModel = ApplicationModel(_modelContext.getModel(ModelType.APPLICATION_MODEL));
			applicationModel.state = ApplicationState.MAIN_MENU;
		}

		private function createMVC():void{
			_modelContext = new ModelContext();
			_controllerContext = new ControllerContext(_modelContext);
			_viewContext = new ViewContext(_modelContext, _controllerContext);

			var formsController:FormsController = FormsController(_controllerContext.getController(ControllerType.FORMS_CONTROLLER));
			formsController.setCanvas(this);
		}
	}
}
