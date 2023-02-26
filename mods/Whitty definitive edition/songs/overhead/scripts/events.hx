import funkin.system.FunkinSprite;
var flashCamera = new FlxCamera();
var bar1:FunkinSprite = new FunkinSprite(0, -560).makeGraphic(1600 * 2, 560, 0xFF000000);
var bar2:FunkinSprite = new FunkinSprite(0, 720).makeGraphic(1600 * 2, 560, 0xFF000000);
var shader = new CustomShader("hueShifter");
var colorizer = new CustomShader("colorizer");
function create() {
	importScript("data/scripts/camera");
	FlxG.cameras.add(flashCamera);
	FlxG.cameras.remove(camHUD,false);
	FlxG.cameras.add(camHUD,false);
	flashCamera.alpha = 0;

	for(i in [bar1, bar2]) {
		add(i);
		i.cameras = [camHUD];
		i.zoomFactor = 0;
	}
	shader.brightness = 0.;
	shader.contrast = 1.;
	shader.saturation = 1.;
	colorizer.colors = [0.325,0.278,0.196];
	camGame.addShader(shader);
	camGame.addShader(colorizer);
	camHUD.addShader(colorizer);
}
function postUpdate(elapsed) {
	flashCamera.scroll = camGame.scroll;
}
function beatHit(curBeat) {
	if (curBeat == 12 || curBeat == 14) {
		curSection.camTarget = 0; enableSmoothFollow(false, 0.1);
	}
	if (curBeat == 15 || curBeat == 13)
		curSection.camTarget = 1;
	if (curBeat == 16){ enableSmoothFollow(true, 0.1);
		FlxTween.tween(bar1, {y: -560 + (5 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
		FlxTween.tween(bar2, {y: 720 + -(5 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
	}
	if (curBeat == 48 || curBeat == 80 || curBeat == 176 || curBeat == 208 || curBeat == 304 || curBeat == 336) {
		enableSmoothFollow(false, 0.1);
		setMotionThing(25);
		flashCamera.alpha = 0.7;
		flashCamera.zoom = camGame.zoom;
		FlxTween.tween(flashCamera, {zoom: camGame.zoom + 0.5, alpha: 0}, Conductor.crochet /500, {ease: FlxEase.circOut});
	}
	if (curBeat == 176 || curBeat == 304) {
		defaultCamZoom = 0.65;
		FlxTween.globalManager.cancelTweensOf(bar1);
		FlxTween.globalManager.cancelTweensOf(bar2);
		FlxTween.tween(bar1, {y: -560 + (7 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
		FlxTween.tween(bar2, {y: 720 + -(7 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
	}
	if (curBeat == 208 || curBeat == 336) {
		defaultCamZoom = 0.8;
		FlxTween.globalManager.cancelTweensOf(bar1);
		FlxTween.globalManager.cancelTweensOf(bar2);
		FlxTween.tween(bar1, {y: -560 + (12 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
		FlxTween.tween(bar2, {y: 720 + -(12 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
	}
	if (curBeat >= 176 && curBeat < 240 || curBeat >= 304 && curBeat < 368) {
		camHUD.zoom += 0.05;
		colorizer.colors = [0.992,0.412,0.133];
	}
	else colorizer.colors = [0.325,0.278,0.196];
	if (curBeat == 240) {
		stage.getSprite("bg").color = 0;
		stage.getSprite("stageFront").color = 0;
		gf.color = 0;
		boyfriend.setColorTransform(1,1,1,1,255,255,255);
		dad.setColorTransform(1,1,1,1,255,255,255,255);
		defaultCamZoom = 0.9;
		FlxTween.globalManager.cancelTweensOf(bar1);
		FlxTween.globalManager.cancelTweensOf(bar2);
		FlxTween.tween(bar1, {y: -560 + (0 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
		FlxTween.tween(bar2, {y: 720 + -(0 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
	}
	if (curBeat == 272) {
		stage.getSprite("bg").color = 0xFFFFFFFF;
		stage.getSprite("stageFront").color = 0xFFFFFFFF;
		gf.color = 0xFFFFFFFF;
		boyfriend.setColorTransform();
		dad.setColorTransform();
	}
	if (curBeat >= 48 && curBeat <= 112) {
		if (curSection.mustHitSection) {
			defaultCamZoom = 0.8;
			FlxTween.globalManager.cancelTweensOf(bar1);
			FlxTween.globalManager.cancelTweensOf(bar2);
			FlxTween.tween(bar1, {y: -560 + (5 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
			FlxTween.tween(bar2, {y: 720 + -(5 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
		}
		else {
			camHUD.zoom += 0.05;
			defaultCamZoom = 1;
			FlxTween.globalManager.cancelTweensOf(bar1);
			FlxTween.globalManager.cancelTweensOf(bar2);
			FlxTween.tween(bar1, {y: -560 + (10 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
			FlxTween.tween(bar2, {y: 720 + -(10 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
		}
	}
	if (curBeat == 112 || curBeat == 240) enableSmoothFollow(true, 0.1);
	if (curBeat == 272) enableSmoothFollow(false, 0.05);
}