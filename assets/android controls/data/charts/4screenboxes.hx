import flixel.ui.FlxSpriteButton;
import openfl.geom.Rectangle;

function create() {
	var width = FlxG.width / 4;
	for (i in 0...4) {
		var button = new FlxSpriteButton(width * i).makeGraphic(width, FlxG.height, [0xFFc24b99, 0xFF00ffff, 0xFF12fa05, 0xFFf9393f][i]);
		button.width = width;
		button.height = FlxG.height;
		button.pixels.fillRect(new Rectangle(10, 10, width - 20, FlxG.height - 20), 0x00000000);
		add(button);
		button.cameras = [camHUD];
		button.alpha = 0.5;
		var k = FlxG.keys.getKey([37, 40, 38, 39][i]);
		button.onDown.callback = function() {
			k.press();
			button.alpha = 1;
		}
		button.onUp.callback = function() {
			k.release();
			button.alpha = 0.5;
		}
	}
}