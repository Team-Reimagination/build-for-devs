import funkin.backend.utils.NativeAPI;

function update() {
	if (FlxG.keys.justPressed.F5)
		FlxG.resetState();

	#if windows
	if (FlxG.keys.justPressed.C)
		NativeAPI.allocConsole();
	#end

	if (FlxG.keys.justPressed.Q)
		FlxG.switchState(new ModState("celeste/CelesteMainMenu"));
	if (FlxG.keys.justPressed.W)
		FlxG.switchState(new ModState("celeste/PlatformerState"));
}