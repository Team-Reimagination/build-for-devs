import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
import flixel.util.FlxSort;
import funkin.backend.utils.NativeAPI;
import sys.FileSystem;
import sys.io.File;
import funkin.backend.assets.ModsFolder;
import flixel.util.FlxSpriteUtil;
import StringTools;
import lime.ui.MouseCursor;
var assetsGroup = new FlxTypedGroup();
var curSelected = 0;
var assetText = new FlxText(10,10,0,"", 24);
var curStage = "idk";
var ongoingFrameLoading = false;
var onDropFile;
var transformShader = new CustomShader("transform");
function create() {
	FlxG.mouse.visible = true;
	NativeAPI.allocConsole();
	FlxG.autoPause = false;
	if (!Paths.assetsTree.existsSpecific("images/stages/" + curStage,null, ModsFolder.currentModFolder == null)) {
		trace("does not exist");
		FileSystem.createDirectory(Paths.assetsTree.getSpecificPath("images/stages/" + curStage, ModsFolder.currentModFolder == null));
	}

	onDropFile = function (path:String) {
		trace(path);
		var split = path.split("\\");
		if (FileSystem.isDirectory(path)) {
			for (i in FileSystem.readDirectory(path)) onDropFile(path + "\\" + i);
			return;
		}
		File.copy(path, Paths.getPath("images/stages/" + curStage + "/" + split[split.length - 1]));
		var spr = new FunkinSprite();
		if (split[split.length - 1].split(".")[1] == "png" && FileSystem.exists(StringTools.replace(path,".png", ".xml")) || split[split.length - 1].split(".")[1] == "xml" && FileSystem.exists(StringTools.replace(path,".xml", ".png"))) {
			trace("oh yes xml time");
			if (!ongoingFrameLoading) {
				ongoingFrameLoading = true;
				return;
			}
			else {
				spr.frames = Paths.getFrames("stages/" + curStage + "/" + split[split.length - 1].split(".")[0]);
				ongoingFrameLoading = false;
			}
		}
		else spr.loadGraphic(Paths.image("stages/" +curStage + "/" + split[split.length - 1].split(".")[0]));
		spr.screenCenter();
		assetsGroup.add(spr);
		spr.ID = assetsGroup.members.indexOf(spr);
		curSelected = spr.ID;
	}

	FlxG.stage.window.onDropFile.add(onDropFile);
	add(assetsGroup);
	add(assetText);
}
var grabbedSprite = false;
var resizing = false;
var vertices = [0,0,0,0];
var skewing = false;
var rotating = false;
function postUpdate() {
	if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenuState());
	if (assetsGroup.members[curSelected] != null){
		var spr = assetsGroup.members[curSelected];
		if (!resizing) {
			vertices = [0,0,0,0];
			spr.centerOrigin();
			skewing = false;
			if ([for (i in spr.x - 3...spr.x + spr.width + 3) i].contains(FlxG.mouse.x)) {
				if ([for (i in spr.y...spr.y + spr.height + 3) i].contains(FlxG.mouse.y)) {
					if ([for (i in spr.x...spr.x + 6) i].contains(FlxG.mouse.x)) vertices[0] = 1;
					if ([for (i in spr.x + spr.width - 6...spr.x + spr.width) i].contains(FlxG.mouse.x)) vertices[1] = 1;
				}
				if ([for (i in spr.y...spr.y + 6) i].contains(FlxG.mouse.y)) vertices[2] = 1;
				if ([for (i in spr.y + spr.height - 6... spr.y + spr.height) i].contains(FlxG.mouse.y)) vertices[3] = 1;

				if ([for (i in spr.x + (spr.width / 2.2)...spr.x + (spr.width / 1.8)) i].contains(FlxG.mouse.x) || [for (i in spr.y + (spr.height / 2.2)...spr.y + (spr.height / 1.8)) i].contains(FlxG.mouse.y) ||
					[for (i in spr.x...spr.x + (spr.width * 0.05)) i].contains(FlxG.mouse.x) && [for (i in spr.y...spr.y + (spr.height * 0.05)) i].contains(FlxG.mouse.y) ||
					[for (i in spr.x + (spr.width / 1.05)...(spr.x + spr.width)) i].contains(FlxG.mouse.x) && [for (i in spr.y...spr.y + (spr.height * 0.05)) i].contains(FlxG.mouse.y) ||
					[for (i in spr.x...spr.x + (spr.width * 0.1)) i].contains(FlxG.mouse.x) && [for (i in spr.y + (spr.height / 1.05)...(spr.y + spr.height)) i].contains(FlxG.mouse.y) ||
					[for (i in spr.x + (spr.width / 1.05)...(spr.x + spr.width)) i].contains(FlxG.mouse.x) && [for (i in spr.y + (spr.height / 1.05)...(spr.y + spr.height)) i].contains(FlxG.mouse.y)) skewing = false;
				else skewing = true;
			}
		}
		if (!vertices.contains(1)) {
			if (FlxG.mouse.overlaps(spr)) {
				if (FlxG.mouse.justPressed) grabbedSprite = true;
				FlxG.stage.window.cursor = MouseCursor.MOVE;
			}
			if (FlxG.mouse.justReleased && grabbedSprite) grabbedSprite = false;
			if (grabbedSprite && FlxG.mouse.pressed) {
				spr.x += FlxG.mouse.deltaX;
				spr.y += FlxG.mouse.deltaY;
			}
		}
		else {
			if (FlxG.mouse.justPressed) resizing = true;
			var thing = [spr.width, spr.height];
			if (resizing) {
				if (skewing) {
					spr.skew.y += (vertices[1] - vertices[0]) * (FlxG.mouse.deltaY / 2);
					spr.skew.x += (vertices[3] - vertices[2]) * (FlxG.mouse.deltaX / 2);
					if (FlxG.keys.pressed.ALT) {
						if (vertices[0] == 1 || vertices[1] == 1) spr.y += FlxG.mouse.deltaY;
						if (vertices[2] == 1 || vertices[3] == 1) spr.x += FlxG.mouse.deltaX;
					}
				}
				else {
					thing[0] = Math.max(thing[0] + (vertices[1] - vertices[0]) * FlxG.mouse.deltaX, 1);
					thing[1] = Math.max(thing[1] + (vertices[3] - vertices[2]) * FlxG.mouse.deltaY, 1);
					spr.x -= (FlxG.keys.pressed.ALT ? (thing[0] - spr.width) / 2 : vertices[0] == 1 ? thing[0] - spr.width : 0);
					spr.y -= (FlxG.keys.pressed.ALT ? (thing[1] - spr.height) / 2 : vertices[2] == 1 ? thing[1] - spr.height : 0);
				}

			}
			if (FlxG.mouse.justReleased) resizing = false;
			spr.scale.set(thing[0] / spr.frameWidth, thing[1] / spr.frameHeight);
			spr.updateHitbox();
		}
		if (vertices[0] + vertices[2] == 2 || vertices[1] + vertices[3] == 2) FlxG.stage.window.cursor = MouseCursor.RESIZE_NWSE;
		else if (vertices[1] + vertices[2] == 2 || vertices[0] + vertices[3] == 2) FlxG.stage.window.cursor = MouseCursor.RESIZE_NESW;
		else if (vertices[0] == 1 || vertices[1] == 1) FlxG.stage.window.cursor = skewing ? MouseCursor.RESIZE_NS : MouseCursor.RESIZE_WE;
		else if (vertices[2] == 1 || vertices[3] == 1) FlxG.stage.window.cursor = skewing ? MouseCursor.RESIZE_WE : MouseCursor.RESIZE_NS;
	}
	if (FlxG.mouse.wheel != 0) {
		if (FlxG.keys.pressed.CONTROL && curSelected + FlxMath.signOf(FlxG.mouse.wheel) < assetsGroup.members.length && curSelected + FlxMath.signOf(FlxG.mouse.wheel) >= 0) {
			curSelected = curSelected + FlxMath.signOf(FlxG.mouse.wheel);
			assetText.text = "Asset #" + curSelected + " selected";
			FlxTween.cancelTweensOf(assetText);
			assetText.alpha = 1;
			FlxTween.tween(assetText, {alpha:0}, 0.3, {startDelay: 0.5});
			for (i in assetsGroup.members) {
				if (i.ID != curSelected) {
					i.alpha = 0.2;
					i.shader = null;
				}
				else {
					i.alpha = 1;
					trace(i.shader);
					i.shader = transformShader;
					trace(i.shader);
				}
			}
		}
		else if (!FlxG.keys.pressed.CONTROL)
			FlxG.camera.zoom += FlxG.mouse.wheel * FlxG.camera.zoom * 0.1;
	}
	if (FlxG.keys.justPressed.DOWN) changeOrder(-1);
	if (FlxG.keys.justPressed.UP) changeOrder(1);

}
function changeOrder(by) {
	var spr = assetsGroup.members[curSelected];
	if (spr.ID + by >= 0) {
		assetsGroup.remove(spr, true);
		assetsGroup.insert(spr.ID + by, spr);
		for (i in assetsGroup.members) i.ID = assetsGroup.members.indexOf(i);
		curSelected = spr.ID;

		assetText.text = "Changed order to " + assetsGroup.members[curSelected].ID;
		FlxTween.cancelTweensOf(assetText);
		assetText.alpha = 1;
		FlxTween.tween(assetText, {alpha:0}, 0.3, {startDelay: 0.5});
	}
	
}