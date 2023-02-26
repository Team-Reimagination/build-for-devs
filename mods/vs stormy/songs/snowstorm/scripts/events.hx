import funkin.system.FunkinSprite;
var shader = new CustomShader("noteskewer");
var fisheye = new CustomShader("fisheye");
var skewer = 0;
var crocheter = Conductor.crochet / 1000;
var bar1:FunkinSprite = new FunkinSprite(-100, -560).makeGraphic(1600 * 2, 560, 0xFF000000);
var bar2:FunkinSprite = new FunkinSprite(-100, 720).makeGraphic(1600 * 2, 560, 0xFF000000);
function postCreate() {
	camHUD.addShader(shader);
	camHUD.addShader(fisheye);
	fisheye.MAX_POWER = 1;
	//shader.skew = 0.1;
	defaultCamZoom = 0.8;
	camGame.fade(0xFF000000, 0.0001);
	//camHUD.fade(0xFF000000, 0.0001);
	for(i in [bar1, bar2]) {
		add(i);
		//i.cameras = [camHUD];
		i.scrollFactor.set();
		i.zoomFactor = 0;
	}
	//FlxTween.num(100, 0.02, 5, {ease:FlxEase.elasticOut}, function(num) {
	//	fisheye.MAX_POWER = num;
	//});
	fisheye.MAX_POWER = 0.1;
}
function postUpdate(elapsed) {
	shader.skew = skewer = lerp(skewer, 0, 0.05);
}
function beatHit(curBeat) {
	switch (curBeat) {
		case 1: camGame.fade(0xFF000000, crocheter * 20, true); camHUD.fade(0xFF000000, 0.01, true);
			FlxTween.num(defaultCamZoom, 0.8, crocheter * 28, {ease:FlxEase.quartInOut}, function(num) {
				defaultCamZoom = num;
			});
			FlxTween.tween(bar1, {y: -560 + (10 * 10)}, crocheter * 5, {ease: FlxEase.quintOut});
			FlxTween.tween(bar2, {y: 720 + -(10 * 10)}, crocheter * 5, {ease: FlxEase.quintOut});
		case 31,64,95,128,160,190,48: 
			var index = [[31, 95, 160] => 0.7, [48] => 0.8, [128, 190] => 1, [64] => 1.18];
			var index2 = [[128, 190] => 11, [160] => 5, [31, 95] => 6];
			for (i in index.keys())
				if (i.contains(curBeat)) defaultCamZoom = index[i];
			for (i in index2.keys())
				if (i.contains(curBeat)) {
					FlxTween.tween(bar1, {y: -560 + (index2[i] * 10)}, crocheter, {ease: FlxEase.quintOut});
					FlxTween.tween(bar2, {y: 720 + -(index2[i] * 10)}, crocheter, {ease: FlxEase.quintOut});
				}
		case 48: camGame.followLerp = 1;
		default: if (curBeat > 31 && curBeat < 64 || curBeat > 95 && curBeat < 162){
			skewer = (curBeat % 2 == 0 ? 0.03 : -0.03);
			camHUD.zoom += 0.08;
			camGame.zoom += 0.07;
			FlxTween.cancelTweensOf(camHUD);
			FlxTween.cancelTweensOf(camGame);
			fisheye.MAX_POWER = 0.1;
			camHUD.angle = (curBeat % 2 == 0 ? 2 : -2);
			camGame.angle = (curBeat % 2 == 0 ? 2 : -2);
			FlxTween.tween(camHUD, {angle: 0}, crocheter, {ease: FlxEase.backOut});
			FlxTween.tween(camGame, {angle: 0}, crocheter, {ease: FlxEase.backOut});
		}
		if (curBeat > 162 || curBeat > 79 && curBeat < 96) {
			camHUD.zoom += 0.07;
			camGame.zoom += 0.07;
		}
	}
	
}