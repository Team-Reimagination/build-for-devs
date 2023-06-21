import funkin.editors.ui.UIState;
function update(elapsed) {
    if (FlxG.keys.justPressed.F5)
        FlxG.resetState();
    if (FlxG.keys.justPressed.F)
        FlxG.switchState(new UIState());
}
    