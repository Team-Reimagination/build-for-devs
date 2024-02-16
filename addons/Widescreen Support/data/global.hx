function update() {
	FlxG.game.resizeGame(1280 * ((FlxG.stage.window.width / FlxG.stage.window.height) - (16/9) + 1), 720);
	FlxG.scaleMode.width = 1280 * ((FlxG.stage.window.width / FlxG.stage.window.height) - (16/9) + 1);
	FlxG.scaleMode.height = 720;
}