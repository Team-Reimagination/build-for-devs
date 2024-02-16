import haxe.xml.Access;
import Xml;
import Type;
import funkin.options.type.TextOption;
import funkin.options.TreeMenu;
import funkin.options.OptionsScreen;
import funkin.menus.credits.CreditsCodename;
function create() {
	var access = Xml.parse(Assets.getText(Paths.xml('config/credits'))).firstElement();
	var selectables = [];
	for (c in FlxG.state.parseCreditsFromXML(access.parent, true))
		selectables.push(c);
	selectables.push(new TextOption("Codename Engine >", "Select this to see all the contributors of the engine!", function() {
		optionsTree.add(Type.createInstance(CreditsCodename, []));
	}));
	selectables.push(new TextOption("Friday Night Funkin'", "Select this to open the itch.io page of the original game to donate!", function() {
		CoolUtil.openURL("https://ninja-muffin24.itch.io/funkin");
	}));
	main = new OptionsScreen('Credits', 'The people who made this possible!', selectables);
}