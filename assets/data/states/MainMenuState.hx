function update() {
	if (FlxG.keys.justPressed.D) {
		FlxG.switchState(new ModState("3dtest"));
	}
}