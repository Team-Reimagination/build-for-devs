function postCreate() {
	var widththing = 1280 * ((FlxG.stage.window.width / FlxG.stage.window.height) - (16/9) + 1);
	camHUD.x = (widththing / 2) - (640);
}