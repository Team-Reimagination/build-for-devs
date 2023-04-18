import("funkin.utils.XMLUtil");
import funkin.editors.ui.UITopMenu;
import StringTools;
import flixel.input.FlxPointer;
import flixel.math.FlxPoint;
import funkin.utils.NativeAPI;
import haxe.io.Path;
import Xml;
import sys.FileSystem;
import sys.io.File;
var follower = new FlxSprite();
var samChar;
var camHUD = new FlxCamera();
var sizeComp;
var dropdown:UITopMenu;
var uigroup = new FlxTypedGroup();
var curCharacterList;
var sillyoulet = new Character(0,0,"zero",false);
var characterList = [for(e in Paths.getFolderContent('data/characters/')) if (Path.extension(e).toLowerCase() == "xml") e.substr(0, e.length-4)];
function create() {
	NativeAPI.allocConsole();
	FlxG.cameras.add(camHUD, false);
	camHUD.bgColor = 0;
	sillyoulet.alpha = 0.6;
	sillyoulet.setColorTransform(1,1,1,1,255,255,255,255);
	add(sillyoulet);
	samChar = new Character(0, 0, "zero", false);
	add(samChar);
	sizeComp = new Character(500,0,"zero", true);
	add(sizeComp);
	sillyoulet.playAnim("idle", false, "LOCK");
	samChar.playAnim("idle", false, "LOCK");
	curCharacterList = [for (i in FlxMath.bound(characterList.indexOf(samChar.curCharacter) - 12, 0, characterList.length)...FlxMath.bound(characterList.indexOf(samChar.curCharacter) + 12, 0, characterList.length)) characterList[i]];
	var array = [
	{
		label: "Select Character",
		childs: [for (i in curCharacterList) {
			label: i,
			onSelect: function(_) {
				remove(sillyoulet);
				sillyoulet = new Character(0, 0, i, false);
				add(sillyoulet);
				sillyoulet.setColorTransform(1,1,1,1,255,255,255,255);
				remove(samChar);
				samChar = new Character(0, 0, i, false);
				add(samChar);
				sillyoulet.playAnim("idle", false, "LOCK");
				samChar.playAnim("idle", false, "LOCK");
				curCharacterList = [for (i in FlxMath.bound(characterList.indexOf(samChar.curCharacter) - 12, 0, characterList.length)...FlxMath.bound(characterList.indexOf(samChar.curCharacter) + 12, 0, characterList.length)) characterList[i]];
				for (i in dropdown.members){
					if (i.label.text == "Select Animation")
						i.contextMenu = [for (i in samChar.animOffsets.keys()) {
							label: i,
							onSelect: function(_) samChar.playAnim(i, false, "LOCK")
						}];
					if (i.label.text == "Select Character")
						i.contextMenu = updateChar();
				} 
			}
		}]
	},
	{
		label: "Select Animation",
		childs: [for (i in samChar.animOffsets.keys()) {
			label: i,
			onSelect: function(_) samChar.playAnim(i, false, "LOCK")
		}]
	},
	{
		label: "Select Character For Size Comparison",
		childs: [for (i in curCharacterList) {
			label: i,
			onSelect: function(_) {
				remove(sizeComp);
				sizeComp = new Character(100, 0, i, true);
				add(sizeComp);
				sizeComp.playAnim("idle", false, "LOCK");
			}
		}]
	}];
	trace(StringTools.replace(array, "},", "}\n"));
	dropdown = new UITopMenu(array);
	dropdown.cameras = uigroup.cameras = [camHUD];
	add(uigroup);
	add(dropdown);
	add(follower);
	var text = new FlxText(0, 0, 1280, "Press H to preview XML in console\nPress J to save XML (overwrite)\nPress arrow keys to play singing animations\nPress WASD to move the offsets
	(or just use mouse)\nHold SPACE to move size comparison object\nHold SHIFT to move camera offset", 20);
	text.scrollFactor.set();
	text.alignment = "right";
	text.cameras = [camHUD];
	add(text);
	FlxG.camera.follow(follower, null, 0.05);
}
var lastMousePos;
var lastSprPos:FlxPoint;
var smoothZoom = 1;
var targetZoom = 1;
function update(elapsed) {
	FlxG.mouse.visible = true;
	targetZoom += (FlxG.mouse.wheel / 20) * targetZoom;
	smoothZoom = CoolUtil.fpsLerp(smoothZoom, targetZoom, 0.05);
	FlxG.camera.zoom = smoothZoom;

	if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenuState());
	if (FlxG.keys.justPressed.DELETE) {
		for (i in samChar.animOffsets) i.set();
		samChar.globalOffset.set();
		samChar.setPosition();
	}
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

	if (FlxG.keys.justPressed.H || FlxG.keys.justPressed.J) {
		var plainXML = Assets.getText(Paths.xml('characters/' + samChar.curCharacter));
		var xml = Xml.parse(plainXML).firstElement();
		xml.set("camx", samChar.cameraOffset.x);
		xml.set("camy", samChar.cameraOffset.y);
		for (i in xml.elements()){
			i.set("x", samChar.animOffsets[i.get("name")].x);
			i.set("y", samChar.animOffsets[i.get("name")].y);
		}
		if (!FlxG.keys.pressed.J) trace(xml.toString());
		if (FlxG.keys.justPressed.J) {
			var realXml = "<!DOCTYPE codename-engine-character>\n" + xml.toString();
			File.saveContent(Assets.getPath(Paths.xml('characters/' + samChar.curCharacter)), realXml);
			trace(File.getContent(Paths.xml('characters/' + samChar.curCharacter)));
			var text = new FlxText(0,0,1280,"Saved Offsets", 50);
			text.screenCenter();
			text.scrollFactor.set();
			text.alignment = "center";
			add(text);
			FlxTween.tween(text, {y: text.y - 100, alpha:0}, 2, {ease:FlxEase.quartOut, onComplete: function(){remove(text);text.destroy();}});
		}
	}

	if (FlxG.mouse.justPressed) {lastMousePos = FlxG.mouse.getPosition();
		if (FlxG.keys.pressed.SPACE) lastSprPos = FlxPoint.get(sizeComp.x, sizeComp.y);
		else if (FlxG.keys.pressed.SHIFT) lastSprPos = FlxPoint.get(samChar.cameraOffset.x, samChar.cameraOffset.y);
		else lastSprPos = FlxPoint.get(samChar.animOffsets[samChar.animation.curAnim.name].x, samChar.animOffsets[samChar.animation.curAnim.name].y);
	}
	var antiMouseX = FlxG.mouse.getScreenPosition().x < 400 || FlxG.mouse.getScreenPosition().x > 722;
	var antiMouseY = FlxG.mouse.getScreenPosition().y < 100 || FlxG.mouse.getScreenPosition().y > 120;
	if (FlxG.mouse.pressed && antiMouseX || FlxG.mouse.pressed && antiMouseY) {
		if (FlxG.keys.pressed.SPACE)
			sizeComp.setPosition(lastSprPos.x + (FlxG.mouse.getPosition().x - lastMousePos.x), lastSprPos.y + (FlxG.mouse.getPosition().y - lastMousePos.y));
		else if (FlxG.keys.pressed.SHIFT) 
			samChar.cameraOffset.set(lastSprPos.x + (FlxG.mouse.getPosition().x - lastMousePos.x), lastSprPos.y + (FlxG.mouse.getPosition().y - lastMousePos.y));
		else {
			samChar.animOffsets[samChar.animation.curAnim.name].x = (samChar.playerOffsets || samChar.flipX ? lastSprPos.x + (FlxG.mouse.getPosition().x - lastMousePos.x) : lastSprPos.x - (FlxG.mouse.getPosition().x - lastMousePos.x));
			samChar.animOffsets[samChar.animation.curAnim.name].y = (samChar.isPlayer ? lastSprPos.y + (FlxG.mouse.getPosition().y - lastMousePos.y):lastSprPos.y - (FlxG.mouse.getPosition().y - lastMousePos.y));
			samChar.playAnim(samChar.animation.curAnim.name, false, "LOCK");
		}
		
	}
	follower.setPosition(samChar.getCameraPosition().x, samChar.getCameraPosition().y);
}

function updateChar() {
	return [for (i in curCharacterList) {
		label: i,
		onSelect: function(_) {
			remove(sillyoulet);
			sillyoulet = new Character(0, 0, i, false);
			add(sillyoulet);
			sillyoulet.setColorTransform(1,1,1,1,255,255,255,255);
			remove(samChar);
			samChar = new Character(0, 0, i, false);
			add(samChar);
			sillyoulet.playAnim("idle", false, "LOCK");
			samChar.playAnim("idle", false, "LOCK");
			curCharacterList = [for (i in FlxMath.bound(characterList.indexOf(samChar.curCharacter) - 12, 0, characterList.length)...FlxMath.bound(characterList.indexOf(samChar.curCharacter) + 12, 0, characterList.length)) characterList[i]];
			for (i in dropdown.members){
				if (i.label.text == "Select Animation")
					i.contextMenu = [for (i in samChar.animOffsets.keys()) {
						label: i,
						onSelect: function(_) samChar.playAnim(i, false, "LOCK")
					}];
				if (i.label.text == "Select Character")
					i.contextMenu = updateChar();
			}
		}
	}];
}