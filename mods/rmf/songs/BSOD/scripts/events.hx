public var defaultChar;
function postCreate() {
	FlxG.sound.cache(Paths.sound("shot"));
	defaultChar = new Character(dad.x, dad.y, "bitchyRonDefault");
	insert(members.indexOf(dad), defaultChar);
	players[0].characters.push(defaultChar);
	dad.visible = false;

	var shader = new CustomShader("colorizer");
	shader.colors = [-0.4, -0.4, -0.1];
	camGame.addShader(shader);
	camHUD.addShader(shader);
	stage.getSprite("stageFront").alpha = 0.7;
	stage.getSprite("idfk").alpha = 0.4;
}
function beatHit(curBeat) {
	if (Conductor.songPosition > 10 && Math.floor(1/FlxG.elapsed) < 60) {
		if (!camHUD.filtersEnabled) camGame.filtersEnabled = false;
		camHUD.filtersEnabled = false;
	}
}