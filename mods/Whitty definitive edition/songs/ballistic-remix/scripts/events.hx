import funkin.system.FunkinSprite;
var shader = new CustomShader("colorizer");
var bar1:FunkinSprite = new FunkinSprite(0, -560).makeGraphic(1600 * 2, 560, 0xFF000000);
var bar2:FunkinSprite = new FunkinSprite(0, 720).makeGraphic(1600 * 2, 560, 0xFF000000);
var camStripes = new FlxCamera;
function create() {
	add(camStripes);
	importScript("data/scripts/camera");
	stage.getSprite("bg").color = 0;
	shader.colors = [-1.5,-1.5,-0.5];
	camGame.addShader(shader);
	camHUD.addShader(shader);
	camHUD.flash(0xFF000000, Conductor.crochet / 100);
	
	for(i in [bar1, bar2]) {
		add(i);
		//i.cameras = [camHUD];
		i.scrollFactor.set();
		i.zoomFactor = 0;
	}
	remove(stage.getSprite("effect"));
	add(stage.getSprite("effect"));
	stage.getSprite("effect").cameras = [camHUD];
}
function update(elapsed) {
	stage.getSprite("effect").alpha = Math.abs(Math.sin(1.5 * (Conductor.songPosition / 1000)));
}
function onDadHit(event) {
	camGame.zoom += 0.03;
	camHUD.zoom += 0.01;
}
function beatHit(curBeat) {
	switch (curBeat) {
		case 40:
			FlxTween.tween(bar1, {y: -560 + (7 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
			FlxTween.tween(bar2, {y: 720 + -(7 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
		case 72:
			defaultCamZoom = 0.65;
			camHUD.flash();
			stage.getSprite("bg").color = 0xFFFFFFFF;
			shader.colors = [0.518,0.196,0.173];
			enableSmoothFollow(false, 0.1);
			setMotionThing(25);
		case 104: enableSmoothFollow(false, 0.03); defaultCamZoom = 0.8;
		case 132: camGame.fade(0xFF000000, Conductor.crochet / 300);
		case 136: camGame.fade(0x000000, 0.00001, true); camHUD.flash();
			defaultCamZoom = 0.65;
			enableSmoothFollow(false, 0.1);
		case 168: 
			camHUD.flash(0xFF000000, Conductor.crochet / 500);
			shader.colors = [-1.5,-1.5,0];
			stage.getSprite("bg").alpha = 0.2;
		case 200: 
			camHUD.flash();
			stage.getSprite("bg").alpha = 1;
			shader.colors = [0.518,0.196,0.173];
			enableSmoothFollow(false, 0.1);
			setMotionThing(25);
			camHUD.shake(0.005, (Conductor.crochet / 1000) * 64);
		case 200...264, 328...391:
			if (curSection.mustHitSection) defaultCamZoom = 0.9;
			else defaultCamZoom = 0.7;
		case 264:
			camHUD.flash(0xFF000000, Conductor.crochet / 500);
			shader.colors = [-0.5,-0.5,0];
			stage.getSprite("bg").alpha = 0.5;
		case 295: FlxTween.globalManager.cancelTweensOf(stage.getSprite("bg")); FlxTween.tween(stage.getSprite("bg"), {alpha: 1}, (Conductor.crochet / 1000) * 18);
		case 324: stage.getSprite("bg").alpha = 0;
		case 328:
			camHUD.shake(0.005, (Conductor.crochet / 1000) * 64);
			camHUD.flash();
			stage.getSprite("bg").alpha = 1;
			shader.colors = [0.718,0.196,0.173];
			enableSmoothFollow(false, 0.1);
			setMotionThing(25);
		case 392:
			shader.colors = [-0.5,-0.5,0];
			stage.getSprite("bg").alpha = 0;
			gf.alpha = 0;
			boyfriend.setColorTransform(1,1,1,1,255,255,255);
			dad.setColorTransform(1,1,1,1,255,255,255,255);
			camHUD.flash(0xFF000000, Conductor.crochet / 500);
			bar1.setColorTransform(1,1,1,1,255,255,255);
			bar2.setColorTransform(1,1,1,1,255,255,255);
			FlxTween.tween(bar1, {y: -560 + (8 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
			FlxTween.tween(bar2, {y: 720 + -(8 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
		case 456:
			stage.getSprite("bg").alpha = 1;
			gf.alpha = 1;
			boyfriend.setColorTransform();
			dad.setColorTransform();
			bar1.setColorTransform();
			bar2.setColorTransform();
		default: 	
			if (curBeat >= 200 && curBeat <= 264 || curBeat >= 328 && curBeat <= 391) {
				if (curSection.mustHitSection) defaultCamZoom = 0.9;
				else defaultCamZoom = 0.7;
			}
			if (curBeat >= 72 && curBeat < 104 || curBeat >= 136 && curBeat <= 168) {
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
	}

}