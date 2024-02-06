function postStateSwitch() {
	if (FlxG.state.controls != null) {
		FlxG.state.controls.addDefaultGamepad(0);
	}
}