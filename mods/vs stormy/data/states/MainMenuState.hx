import funkin.system.FunkinSprite;
var shader = new CustomShader("weirdassthing");
function postCreate() {
	var bluecube3 = new FunkinSprite(-100, -10).loadGraphic(Paths.image("imbluedabedidabadai"));
	bluecube3.angle = 1;
	bluecube3.color = 0xFF000022;
	bluecube3.scale.y += 0.1;
	var redcube3 = new FunkinSprite(80, -10).loadGraphic(Paths.image("angrybirdsred"));
	redcube3.color = 0xFF220000;
	redcube3.angle = -2;
	redcube3.scale.y += 0.1;
	var bluecube1 = new FunkinSprite(-120).loadGraphic(Paths.image("imbluedabedidabadai"));
	bluecube1.zoomFactor = 2;
	var redcube1 = new FunkinSprite(100).loadGraphic(Paths.image("angrybirdsred"));
	redcube1.zoomFactor = 2;
	for (i in [redcube3, redcube1, bluecube3, bluecube1]) {
		i.scrollFactor.set();
		insert(members.indexOf(menuItems), i);
		i.shader = shader;
		i.antialiasing = false;
	}
        bluecube3.shader = null;
        redcube3.shader = null;
	var bg:FunkinSprite = new FunkinSprite(-80).loadGraphic(Paths.image('menus/menuBG'));
	bg.zoomFactor = 0.4;
	bg.shader = new CustomShader("stormyshader");
	bg.scrollFactor.set();
	insert(members.indexOf(redcube3), bg);
	var it = 0;
	for (i in menuItems) {
		i.x = 100;
		i.scale.set(0.8,0.8);
		i.y = 400 + (it % 2) * 200;
		it++;
		i.updateHitbox();
		i.centerOffsets();
	}
}
var time:Float = 0;
var elapsedMult:Int = 1;
function postUpdate(elapsed) {
	var it = 0;
	for (i in menuItems) {
		i.x = it < 2 ? 50 : 1230 - i.width;
		it++;
	}
	time += elapsed * elapsedMult;
	shader.iTime = time;
	elapsedMult = lerp(elapsedMult, 5, 0.1);
	if (FlxG.keys.justPressed.K) {
		FlxG.switchState(new ModState("charOffset"));
	}
}
function beatHit(curBeat) {
	elapsedMult = 100;
	FlxG.camera.zoom = 1.03;
	FlxG.camera.angle += curBeat % 2 == 0 ? -1 : 1;
	FlxTween.globalManager.cancelTweensOf(FlxG.camera);
	FlxTween.tween(FlxG.camera, {zoom: 1, angle: 0}, Conductor.crochet/1000, {ease: FlxEase.circOut});
}	
