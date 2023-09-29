import funkin.game.HudCamera;
import flixel.FlxObject;
var gridCamera = new FlxCamera();
var scrollBarCamera = new FlxCamera();
function postCreate() {
	charterCamera = new HudCamera();
	charterCamera.downscroll = true;
	scrollBarCamera.height += topMenuSpr.bHeight;
	charterCamera.y = topMenuSpr.bHeight;
	gridCamera.y = topMenuSpr.bHeight;
	FlxG.cameras.add(gridCamera, false);
	FlxG.cameras.add(charterCamera, false);
	FlxG.cameras.remove(uiCamera, false);
	FlxG.cameras.add(uiCamera, false);
	FlxG.cameras.add(scrollBarCamera, false);
	charterCamera.bgColor = 0;
	gridCamera.bgColor = 0;
	scrollBarCamera.bgColor = 0;
	gridCamera.flashSprite.scaleY = -1;
	scrollBarCamera.flashSprite.scaleY = -1;
	notesGroup.camera = eventsGroup.camera = selectionBox.camera = strumlineAddButton.camera = strumlineLockButton.camera = strumlineInfoBG.camera = strumLines.camera = charterCamera;
	addEventSpr.cameras = [charterCamera];
	gridBackdrops.cameras = eventsBackdrop.cameras = charterBG.cameras = [gridCamera];
	charterBG.zoomFactor = 1;
	scrollBar.cameras = [scrollBarCamera];
	scrollBar.scrollFactor.set(0, 1);
}
var __lastMouse:Float = 0;
function preUpdate(elapsed) {
	__lastMouse = FlxG.mouse._globalScreenY;
	if (FlxG.mouse.screenY > 25)
		FlxG.mouse._globalScreenY = 770 - FlxG.mouse._globalScreenY;
	if (true) {
		__crochet = ((60 / Conductor.bpm) * 1000);
		if (!FlxG.keys.pressed.CONTROL)
			Conductor.songPosition += ((__crochet * FlxG.mouse.wheel) - Conductor.songOffset) * 2;
	}
}
function postUpdate(elapsed) {
	for (i in notesGroup.members)
		if (i.flipY != true) i.flipY = true;
	FlxG.mouse._globalScreenY = __lastMouse;
	gridCamera.scroll = charterCamera.scroll;
	gridCamera.zoom = charterCamera.zoom;
}