import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;
import funkin.system.Paths;
import flixel.text.FlxTextBorderStyle;

class MenuButton extends flixel.text.FlxText {
	public function new(X:Float = 0, Y:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 8) {
		super(X, Y, FieldWidth, Text, Size);

		font = Paths.font('Renogare-Regular.otf');
		size *= 2;
		scale.set(0.5, 0.5);
		updateHitbox();
		fieldWidth = (width + 10) * 2;
		alignment = "center";
		antialiasing = true;

		borderStyle = FlxTextBorderStyle.OUTLINE;
		borderSize = 2;
		borderColor = 0xFF000000;

		active = true;

		trace("loaded");
	}

	var targetItem = 0;

	var colorTimer = 0.1;
	var isGreen = true;

	/*public override function update(elapsed:Float) {
		super.update(elapsed);

		trace(targetItem);

		if(targetItem == 0) {
			colorTimer -= elapsed;
			while(colorTimer <= 0) {
				colorTimer += 0.3;
				isGreen = !isGreen;
			}
			color = isGreen ? 0xFF00FF00 : 0xFFffff00;
		} else {
			color = 0xFFFFFFFF;
		}
	}*/

	public function updateTempFix(elapsed:Float) {
		if(targetItem == 0) {
			colorTimer -= elapsed;
			while(colorTimer <= 0) {
				colorTimer += 0.1;
				isGreen = !isGreen;
			}
			color = isGreen ? 0xFF00FF00 : 0xFFffff00;
		} else {
			color = 0xFFFFFFFF;
		}
	}
}