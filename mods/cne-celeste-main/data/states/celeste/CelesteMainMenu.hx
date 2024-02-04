import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;
import funkin.system.Paths;
import flixel.text.FlxTextBorderStyle;
import MenuButton;

var ref_img:FlxSprite;

var text_climb:MenuButton;
var text_pico:MenuButton;
var text_options:MenuButton;
var text_credits:MenuButton;
var text_exit:MenuButton;
var textElements:Array<MenuButton> = [];

function create() {
	var tempbg = new FlxSprite().makeGraphic(1, 1, 0xFF666666);
	tempbg.scale.set(FlxG.width, FlxG.height);
	tempbg.updateHitbox();
	add(tempbg);

	ref_img = new FlxSprite().loadGraphic(Paths.image('- ref'));
	ref_img.setGraphicSize(FlxG.width, FlxG.height);
	ref_img.updateHitbox();
	ref_img.antialiasing = true;
	ref_img.screenCenter();
	add(ref_img);

	var baseX = 164;
	var offset = 53.5;

	text_climb = new MenuButton(125, 260.7, 0, "CLIMB", 45);
	text_pico = new MenuButton(baseX, 332.7, 0, "PICO-8", 30);
	text_options = new MenuButton(baseX, text_pico.y + offset, 0, "Options", 30);
	text_credits = new MenuButton(baseX, text_options.y + offset, 0, "Credits", 30);
	text_exit = new MenuButton(baseX, text_credits.y + offset, 0, "Exit", 30);

	//FlxG.game.debugger.console.registerObject("text_climb", text_climb);
	//FlxG.game.debugger.console.registerObject("text_pico", text_pico);
	//FlxG.game.debugger.console.registerObject("text_options", text_options);
	//FlxG.game.debugger.console.registerObject("text_credits", text_credits);
	//FlxG.game.debugger.console.registerObject("text_exit", text_exit);

	textElements = [text_climb, text_pico, text_options, text_credits, text_exit];

	for(text in textElements) {
		add(text);
		trace(text.text + " loaded");
	}

	changeSelection(0);
}

var curSelected = 0;

var ri = 0;
var r = [1, 0.5, 0];

// fun fact, this is the same code i used for funkscop menus
// oh shit!! god i love funkscop

function update() {
	ref_img.alpha = r[ri];
	if (FlxG.keys.justPressed.J)
		ri = (ri + 1) % r.length;

	if (FlxG.keys.justPressed.F4) // changing to f4 bc it don't work :(
		FlxG.switchState(new ModState("celeste/CelesteMainMenu"));

	if (FlxG.keys.justPressed.ESCAPE)
		FlxG.switchState(new MainMenuState());
}

function mod(n:Int, m:Int) {
	return ((n % m) + m) % m;
}

function update(elapsed) {
	for(t in textElements) t.updateTempFix(elapsed); // temporary fix

	if(controls.UP_P) changeSelection(-1);
	if(controls.DOWN_P) changeSelection(1);

	if(controls.ACCEPT) {
		if(curSelected == 0) {
			FlxG.switchState(new ModState("celeste/PlatformerState"));
		}
	}
}

function changeSelection(change) {
	curSelected = mod(curSelected + change, textElements.length);

	var i = 0;
	for(text in textElements) {
		text.targetItem = i - curSelected;
		i++;
	}
}