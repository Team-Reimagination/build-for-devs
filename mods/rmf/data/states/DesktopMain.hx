import funkin.desktop.editors.CharacterEditor;
import funkin.desktop.windows.Window;
import flixel.addons.ui.FlxUIDropDownMenu;
import StringTools;
var samChar;
function postCreate() {
	var sillyoulet = new Character(0,0,"zero",false);
	sillyoulet.alpha = 0.6;
	sillyoulet.setColorTransform(1,1,1,1,255,255,255,255);
	add(sillyoulet);
	samChar = new Character(0, 0, "zero", false);
	add(samChar);
	var array = [];
	for (i in samChar.animOffsets.keys()) array.push(i);
	var dropdown = new FlxUIDropDownMenu(600, 100, FlxUIDropDownMenu.makeStrIdLabelArray(array), function(anim) {
		samChar.playAnim(anim, false, "LOCK");
	});
	add(dropdown);
}
function postUpdate(elapsed) {
	if (FlxG.keys.justPressed.LEFT) samChar.playAnim("singLEFT", false, "LOCK");
	if (FlxG.keys.justPressed.RIGHT) samChar.playAnim("singRIGHT", false, "LOCK");
	if (FlxG.keys.justPressed.UP) samChar.playAnim("singUP", false, "LOCK");
	if (FlxG.keys.justPressed.DOWN) samChar.playAnim("singDOWN", false, "LOCK");
	if (FlxG.keys.justPressed.M) samChar.playAnim("idle", false, "LOCK");

	if (FlxG.keys.justPressed.A) {samChar.animOffsets[samChar.animation.curAnim.name].x += (FlxG.keys.pressed.SHIFT ? 10 : 0.5);
		samChar.playAnim(samChar.animation.curAnim.name, false, "LOCK");}
	if (FlxG.keys.justPressed.D) {samChar.animOffsets[samChar.animation.curAnim.name].x -= (FlxG.keys.pressed.SHIFT ? 10 : 0.5);
		samChar.playAnim(samChar.animation.curAnim.name, false, "LOCK");}
	if (FlxG.keys.justPressed.W) {samChar.animOffsets[samChar.animation.curAnim.name].y += (FlxG.keys.pressed.SHIFT ? 10 : 0.5);
		samChar.playAnim(samChar.animation.curAnim.name, false, "LOCK");}
	if (FlxG.keys.justPressed.S) {samChar.animOffsets[samChar.animation.curAnim.name].y -= (FlxG.keys.pressed.SHIFT ? 10 : 0.5);
		samChar.playAnim(samChar.animation.curAnim.name, false, "LOCK");}

	if (FlxG.keys.justPressed.H) {
		var offs = samChar.animOffsets;
		for (i in offs.keys()) {
			var offsetString = i + ': x="' + offs[i].x + '" y="' + offs[i].y + '"';
			trace(offsetString);
		}
	}
}