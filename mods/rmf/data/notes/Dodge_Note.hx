function onPlayerHit(event) {
	if (event.noteType == "Dodge_Note") {
		FlxG.sound.play(Paths.sound("shot"));
		event.preventAnim();
		event.showSplash = false;
		boyfriend.playAnim(["dodgeLEFT", "dodgeDOWN", "dodgeUP", "dodgeRIGHT"][event.direction]);
		if (!dad.visible) dad.visible = true;
		if (defaultChar.visible) defaultChar.visible = false;
		dad.playAnim("shoot");
	}
}
function onPlayerMiss(event) {
	if (event.noteType == "Dodge_Note") {
		FlxG.sound.play(Paths.sound("shot"));
		FlxG.sound.play(Paths.sound("hitmarker"));
		health -= 1;
		event.characters = [];
		boyfriend.playAnim("hit");
		if (!dad.visible) dad.visible = true;
		if (defaultChar.visible) defaultChar.visible = false;
		dad.playAnim("shoot");

	}
}