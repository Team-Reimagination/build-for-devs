import flx3d.Flx3DView;
import away3d.controllers.FirstPersonController;
var _cameraController;
var view:Flx3DView;
function create() {
	trace("h");
	view = new Flx3DView(0, 0, 1280, 720);
	add(view);
	view.addModel(Paths.obj("portal"), function(e) {
	}, null, false);
	_cameraController = new FirstPersonController(view.view.camera, 0, 0, -90, 90);
}

var moveSpeed:Float = 400;
function update(elapsed:Float) {
	if (FlxG.keys.pressed.W)
		_cameraController.incrementWalk(moveSpeed * elapsed);
	if (FlxG.keys.pressed.S)
		_cameraController.incrementWalk(-moveSpeed * elapsed);
	if (FlxG.keys.pressed.A)
		_cameraController.incrementStrafe(-moveSpeed * elapsed);
	if (FlxG.keys.pressed.D)
		_cameraController.incrementStrafe(moveSpeed * elapsed);
}

function onDestroy() {
	view.destroy();
}