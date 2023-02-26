import funkin.system.FunkinSprite;
var julian2; var julian3; var julian3neon;
var gfneon; var bfneon; var ogbf;
var leCondu = Conductor.crochet / 1000;
var colorer = new CustomShader("colorizer");
var jacker = new FlxSprite(-1000, 500).loadGraphic(Paths.image("stages/better/number12COCK"));
var flashCamera = new FlxCamera();
var bar1:FunkinSprite = new FunkinSprite(0, -560).makeGraphic(1600 * 2, 560, 0xFF000000);
var bar2:FunkinSprite = new FunkinSprite(0, 720).makeGraphic(1600 * 2, 560, 0xFF000000);
function create() {
	importScript("data/scripts/camera");	stage.getSprite("bgswag").alpha = 0;
	FlxG.cameras.add(flashCamera);			stage.getSprite("stageFrontswag").alpha = 0;
	FlxG.cameras.remove(camHUD,false);			
	FlxG.cameras.add(camHUD,false);
	flashCamera.alpha = 0;
	for(i in [bar1, bar2]) {
		add(i);
		i.cameras = [camHUD];
		i.zoomFactor = 0;
	}

	bfneon = new Character(boyfriend.x, boyfriend.y, "bfneon", true);	gfneon = new Character(gf.x, gf.y, "gf-whittyneon");	ogbf = new Character(boyfriend.x, boyfriend.y, "bf", true);		
	bfneon.visible = false;												gfneon.visible = false;									ogbf.visible = false;									
	add(bfneon);														add(gfneon);											add(ogbf);													

	julian3 = new Character(dad.x, dad.y, "julian3");	julian3neon = new Character(dad.x, dad.y, "julian3neon");	julian2 = new Character(dad.x, dad.y, "julian2");
	julian3.visible = false;							julian3neon.visible = false;								julian2.visible = false;
	add(julian3);										add(julian3neon);											add(julian2);											

	camGame.addShader(colorer); colorer.colors = [-0.014,-0.351,-0.212];
	camHUD.addShader(colorer);
	flashCamera.addShader(colorer);
	add(jacker); jacker.scale.set(5, 5); jacker.visible = false;
}
function postUpdate(elapsed) if (flashCamera != null) flashCamera.scroll = FlxG.camera.scroll;
function beatHit(curBeat) {
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
	if (curBeat >= 176 && curBeat <= 240 || curBeat >= 312 && curBeat <= 368) {camHUD.zoom += 0.04;camGame.zoom += 0.04;}
	switch (curBeat) {
		case 12,14: curSection.camTarget = 1; enableSmoothFollow(false, 0.1);
		case 15,13: curSection.camTarget = 0;
		case 16: 	enableSmoothFollow(true, 0.1);
					FlxTween.tween(bar1, {y: -560 + (5 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
					FlxTween.tween(bar2, {y: 720 + -(5 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
		case 48: 	dad.visible = false; dad = julian2; julian2.visible = true;
					enableSmoothFollow(false, 0.1); setMotionThing(25);
					flashCamera.zoom = FlxG.camera.zoom; flashCamera.alpha = 0.7; FlxTween.tween(flashCamera, {zoom: FlxG.camera.zoom + 0.2, alpha: 0}, Conductor.crochet /500, {ease: FlxEase.circOut});
		case 80:	flashCamera.zoom = FlxG.camera.zoom; flashCamera.alpha = 0.7; FlxTween.tween(flashCamera, {zoom: FlxG.camera.zoom + 0.2, alpha: 0}, Conductor.crochet /500, {ease: FlxEase.circOut});
		case 112:	flashCamera.zoom = FlxG.camera.zoom; flashCamera.alpha = 0.7; FlxTween.tween(flashCamera, {zoom: FlxG.camera.zoom + 0.2, alpha: 0}, Conductor.crochet /500, {ease: FlxEase.circOut});
					colorer.colors = [-0.5,-0.5,0]; enableSmoothFollow(true, 0.1);
		case 176:	FlxG.camera.bgColor = 0xFFFFFFFF; 	colorer.colors = [1,0,0.2]; flashCamera.zoom = FlxG.camera.zoom; flashCamera.alpha = 0.7; FlxTween.tween(flashCamera, {zoom: FlxG.camera.zoom + 0.2, alpha: 0}, Conductor.crochet /500, {ease: FlxEase.circOut});
					enableSmoothFollow(false, 0.1);	defaultCamZoom = 0.7;
					FlxTween.tween(bar1, {y: -560 + (6 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
					FlxTween.tween(bar2, {y: 720 + -(6 * 10)}, Conductor.crochet / 1000, {ease: FlxEase.quintOut});
		case 208: 	stage.getSprite("bg").alpha = 0; camHUD.flash();
					stage.getSprite("stageFront").alpha = 0;
		case 240: 	FlxTween.tween(jacker, {x: 3000}, leCondu, {ease: FlxEase.quartOut}); jacker.visible = true;
					colorer.colors = [-0.014,-0.351,-0.212];
					stage.getSprite("bgswag").alpha = 1;
					stage.getSprite("stageFrontswag").alpha = 1;
					julian2.visible = false; dad = julian3neon; julian3neon.visible = true;
					boyfriend.visible = false; boyfriend = bfneon; bfneon.visible = true;
					gf.visible = false; gfneon.visible = true; gf.alpha = 1;
					stage.getSprite("bg").alpha = 0;
					stage.getSprite("stageFront").alpha = 0;
					defaultCamZoom = 1; enableSmoothFollow(true, 0.1); 
		case 272: 	julian3neon.visible = false; dad = julian3; julian3.visible = true;
					bfneon.visible = false; boyfriend = ogbf; ogbf.visible = true;
					gfneon.visible = false; gf.visible = true;
					FlxTween.tween(stage.getSprite("bg"), {alpha: 1}, leCondu);
					FlxTween.tween(stage.getSprite("stageFront"), {alpha: 1}, leCondu);
					defaultCamZoom = 0.87;
		case 278: 	stage.getSprite("bgswag").alpha = 0;
					stage.getSprite("stageFrontswag").alpha = 0;
		case 303:	defaultCamZoom = 1;
		case 312:	defaultCamZoom = 0.8; enableSmoothFollow(false, 0.1);  FlxG.camera.bgColor = 0xFFFFFFFF; 	colorer.colors = [1,0,0.2]; flashCamera.zoom = FlxG.camera.zoom; flashCamera.alpha = 0.7; FlxTween.tween(flashCamera, {zoom: FlxG.camera.zoom + 0.2, alpha: 0}, Conductor.crochet /500, {ease: FlxEase.circOut});
		case 336: 	stage.getSprite("bg").alpha = 0; camHUD.flash();
					stage.getSprite("stageFront").alpha = 0;
		case 368:	boyfriend.alpha = 1;
					gf.alpha = 1;		stage.getSprite("stageFront").alpha = 1;
					julian2.alpha = 1; 	stage.getSprite("bg").alpha = 1; colorer.colors = [0,0,0];
					
	}
}