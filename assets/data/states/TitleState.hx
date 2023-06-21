function create() {
	var sprite = new FunkinSprite().loadGraphic(Paths.image("dumb/Isabelle_AF"));
	sprite.zoomFactor = -1;
	add(sprite);
}
function update(elapsed) {
	FlxG.camera.zoom += FlxG.mouse.wheel * FlxG.camera.zoom * 0.1;
	if (FlxG.keys.pressed.D) FlxG.camera.scroll.x += 1;
	if (FlxG.keys.pressed.A) FlxG.camera.scroll.x -= 1;
	if (FlxG.keys.pressed.S) FlxG.camera.scroll.y += 1;
	if (FlxG.keys.pressed.W) FlxG.camera.scroll.y -= 1;
}