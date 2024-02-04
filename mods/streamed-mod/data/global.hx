
import funkin.backend.assets.ScriptedAssetLibrary;
import funkin.backend.assets.ModsFolder;
import funkin.backend.scripting.Script;
import funkin.backend.scripting.GlobalScript;
import funkin.backend.scripting.DummyScript;

static var loadedModName = "";
static var hasLibFunction = Reflect.hasField(ModsFolder, "useLibFile");

Paths.assetsTree.addLibrary(new ScriptedAssetLibrary("streaming", []));

function loadGlobalHx() {
	trace("Trying to load global.hx for " + loadedModName);
	if(hasLibFunction) {
		var path = Paths.script('data/global/LIB_' + loadedModName);
		var script = Script.create(path);
		if (Std.isOfType(script, DummyScript)) return;
		script.fileName = '$i:global.hx';
		GlobalScript.scripts.add(script);
		script.load();
	} else {
		GlobalScript.onModSwitch();
	}
	trace("Loaded global.hx for " + loadedModName);
}

loadGlobalHx();

//trace(ModsFolder.getLoadedMods());