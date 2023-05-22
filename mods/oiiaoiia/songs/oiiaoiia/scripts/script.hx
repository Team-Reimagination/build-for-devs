import flixel.effects.particles.FlxTypedEmitter;
import flixel.addons.effects.FlxTrailArea;
var oiiaoiia = false;
var vignetter = new CustomShader("vignette");
var fisheyer = new CustomShader("fisheye");
var textGrp = new FlxGroup();
var emitter = new FlxTypedEmitter(-500, -200, 1000);
var bf;
var trailArray = [];
var pseudoCameras = [camGame];
var spinner = new FlxSprite(-300, 75);
var flasher = new FlxSprite(-500, -100).makeGraphic(1280, 720, 0xFFFFFFFF);
var cutscener = new FlxSprite();
var exploder = new FlxSprite(-270, 80);
function postCreate() {
	exploder.frames = Paths.getFrames("explode");
	exploder.animation.addByPrefix("idle", "idle", 30, false);
	exploder.scale.set(2.3,2.3);
	cutscener.frames = Paths.getFrames("explodeinground");
	cutscener.animation.addByPrefix("idle", "idle", 30, false);
	spinner.frames = Paths.getFrames("kitty");
	spinner.animation.addByPrefix("idle", "spinner", 240, true);
	spinner.animation.play("idle");
	spinner.scale.set(2,2);
	add(spinner);
	spinner.visible = false;
	healthBar.visible = healthBarBG.visible = iconP1.visible = iconP2.visible = false;
	bf = strumLines.members[0].characters[0];
	emitter.loadParticles(Paths.image("glow"), 200);
	emitter.start(false, 0.01);
	emitter.alpha.set(1, 1, -2, -2);
	emitter.scale.set(0.01, 0.01, 0.01, 0.01, 0.2, 0.2, 0.5, 0.5);
	emitter.keepScaleRatio = true;
	emitter.width = emitter.height = 1000;
	for (i in 0...3) {
		var fulltext = "oiiaoiia ";
		for (j in 0...75) {
			var txt = new FlxText(-8000 + j * 338, 100 + (i * 75 - (i % 3 * 10)), 0, "oiiaoiia ", 64 - (i % 2 * 20));
			txt.ID = i;
			if (i%2 == 1){
				txt.y += 10;
				txt.color = 0xFF777777;
			} 
			textGrp.add(txt);
		}
	}
	insert(members.indexOf(bf), textGrp);
	textGrp.visible = false;
	camHUD.alpha = 0;
	camGame.addShader(fisheyer);
	FlxG.sound.play(Paths.sound("begin"));
	bf.playAnim("idle alt");
	bf.animation.curAnim.frameRate = 90;
	new FlxTimer().start(1.7, function() {
		bf.playAnim("idle");
		new FlxTimer().start(1.1, function() {
			bf.playAnim("idle alt");
			bf.animation.curAnim.frameRate = 30;
			new FlxTimer().start(2.1, function() {
				bf.playAnim("idle");
				camGame.addShader(vignetter);
				new FlxTimer().start(.4, function() {
					oiiaoiia = true;
					startCountdown();
					startTimer.cancel();
					FlxTween.tween(camHUD, {alpha: 1}, 0.1);
					FlxG.camera.follow();
				});
			});
		});
	});
	add(flasher);
	flasher.alpha = 0;
}
var textvel = 1;
function postUpdate(elapsed) {
	if (!PlayState.chartingMode) PlayState.chartingMode = true;
	if (Conductor.songPosition > 0 && curBeat < 16) stage.getSprite("bg").color = FlxColor.fromHSB(FlxMath.wrap(Conductor.songPosition,0,360), 0.6,2);
	if (curStep > 28) for (i in textGrp) {
			if (curBeat < 32) i.x += i.ID % 2 == 1 ? -4 : 4;
			else i.x += i.ID % 2 == 1? -textvel : textvel;
		}
	textvel = lerp(textvel, 1, 0.1);
	if (curBeat > 14 && curBeat < 60 || curStep >= 385 && curStep < 512) {
		var trial = new Character(0,0,"thicccat69", bf.isPlayer);
		trial.setPosition(bf.x, bf.y);
		trial.playAnim(bf.animation.curAnim.name);
		trial.setColorTransform(1,1,1,50,50,50,50);
		insert(members.indexOf(bf), trial);
		trailArray.push(trial);
		FlxTween.tween(trial, {alpha: 0}, Conductor.crochet/1000, {onComplete: function() {
			remove(trial);
			trial.destroy();
		}});
		for (i in trailArray) {
			i.color = FlxColor.fromHSB(FlxMath.wrap(Conductor.songPosition,0,360), 1,1);
		}
	}
	if (curStep > 256)
		flasher.alpha = FlxG.random.float(0, 0.6);
	if (curStep >= 284 && curStep < 289 || curStep >= 316 && curStep < 321) bf.playAnim("idle");
	if (curStep >= 512) {bf.playAnim("idle alt");bf.animation.curAnim.frameRate = 90;}
}
function onStartCountdown(event)
	if (!oiiaoiia) event.cancel();

function stepHit(curStep) {
	switch (curStep) {
		case 28, 30, 32: textGrp.visible = true;
		case 29, 31: textGrp.visible = false;
		case 256: spinner.visible = false;
		textGrp.visible = false;
		case 284: stage.getSprite("bg").color = 0xFFFFFFFF;
		for (i in pseudoCameras) if (i != camGame) {FlxG.cameras.remove(i); i.destroy();}
		flasher.visible = false;
		case 289: stage.getSprite("bg").color = 0;
		bf.setColorTransform(1,1,1,1,255,255,255);
		flasher.visible = true;
		case 316: stage.getSprite("bg").color = 0xFFFFFFFF;
		bf.setColorTransform();
		flasher.visible = false;
		for (i in pseudoCameras) if (i != camGame) {FlxG.cameras.remove(i); i.destroy();}
		defaultCamZoom += 2;
		camGame.zoom += 2;
		case 321: stage.getSprite("bg").color = 0;
		flasher.visible = true;
		defaultCamZoom -= 1.5;
		camGame.zoom -= 1.5;
		flasher.visible = false;
		bf.setColorTransform(1,1,1,1,255,255,255);
		FlxTween.num(defaultCamZoom, defaultCamZoom + 1, (Conductor.stepCrochet/1000) * 27, {}, function(num) {
			defaultCamZoom = num;
		});
		case 348:
		camGame.fade(0.0001, 0xFF000000);
		cutscener.screenCenter();
		cutscener.cameras = [camHUD];
		cutscener.animation.play("idle");
		add(cutscener);
		for (i in pseudoCameras) if (i != camGame) {FlxG.cameras.remove(i); i.destroy();}
		case 385: remove(cutscener);
		camGame.fade(0.0001, 0, true);
		bf.setColorTransform();
		FlxTween.num(1.4, 4, (Conductor.stepCrochet/1000) * 126, {}, function(num) defaultCamZoom = num);
		camGame.zoom = 1.4;
		FlxTween.tween(camGame.scroll, {x: camGame.scroll.x + 100, y: camGame.scroll.y - 20}, (Conductor.stepCrochet/1000) * 126);
		case 512:
		bf.cameras = [FlxG.camera];
		strumLines.members[0].characters = [];
		FlxTween.cancelTweensOf(camGame.scroll);
		stage.getSprite("bg").color = 0xFFFFFFFF;
		camGame.zoom = 1.4;
		defaultCamZoom = 1.4;
		camGame.scroll.set(camGame.scroll.x - 100,camGame.scroll.y + 20);
		case 532: add(exploder);
		bf.visible = false;
		exploder.animation.play("idle");
	}
	if (curStep > 256 && curStep < 284 || curStep >= 289 && curStep < 316 || curStep >= 321 && curStep < 321) {
		var newCam = new FlxCamera(0,0,0,0,0);
		newCam.zoom = 0.0001;
		newCam.scroll.x = camGame.scroll.x - Math.sin(curStep >= 289 && curStep < 316 ? -curStep : curStep) * 100;
		newCam.scroll.y = camGame.scroll.y - Math.sin(curStep + (Math.PI/ 2)) * 100;
		FlxTween.tween(newCam.scroll, {x: camGame.scroll.x - Math.sin(curStep >= 289 && curStep < 316 ? -curStep : curStep) * 600, y: camGame.scroll.y - Math.sin(curStep + (Math.PI/ 2)) * 600}, (Conductor.crochet / 1000) * 3);
		FlxTween.tween(newCam, {zoom:3}, (Conductor.crochet / 1000) * 3, {onComplete: function() {
			FlxG.cameras.remove(newCam);
			newCam.destroy();
		}});
		FlxG.cameras.add(newCam, false);
		FlxG.cameras.bgColor = 0x00000000;
		for (i in members) {
			if (i != bf && i?.cameras?.contains(newCam)) i?.cameras?.remove(newCam);
		}
		pseudoCameras.push(newCam);
		bf.cameras = pseudoCameras;
	}
	
}
var camBeatStage = 0;
function beatHit(curBeat) {
	textvel = 10;
	switch (curBeat) {
		case 0: camGame.removeShader(vignetter);
		case 14: FlxTween.num(0, -0.5, (Conductor.crochet / 1000) * 2, {ease: FlxEase.quartIn}, function(num) fisheyer.MAX_POWER = -(Math.round(num * 1000) / 1000));
		case 16: FlxTween.num(-.9, 0, (Conductor.crochet / 1000), {ease: FlxEase.quartOut, onComplete: function() camGame.removeShader(fisheyer)}, function(num) fisheyer.MAX_POWER = -(Math.round(num * 1000) / 1000));
		stage.getSprite("bg").color= 0;
		insert(members.indexOf(textGrp),emitter);
		FlxTween.num(defaultCamZoom, defaultCamZoom + 0.8, (Conductor.crochet / 1000) * 13, {ease: FlxEase.linear}, function(num) defaultCamZoom = num);
		FlxTween.tween(FlxG.camera.scroll, {y: FlxG.camera.scroll.y + 45}, (Conductor.crochet / 1000) * 12);
		case 29: FlxG.camera.fade(0xFFFFFFFF, (Conductor.crochet / 1000) * 3);
		case 32: bf.setColorTransform(1,1,1,1,255,255,255);
		for (i in textGrp) i.alpha = 0.4;
		defaultCamZoom = 1.4;
		FlxG.camera.scroll.y -= 45;
		FlxG.camera.fade(0xFFFFFFFF, Conductor.crochet / 1000, true);
		var tween = FlxTween.tween(bf, {x: FlxG.random.float(-400, 400), y: FlxG.random.float(-200, 200)}, (Conductor.crochet / 1000) * 0.15, {type: 1, ease: FlxEase.quartIn});
		tween.onComplete = function(twn) {
			twn.then(FlxTween.tween(bf, {x: FlxG.random.float(-400, 400), y: FlxG.random.float(-200, 200)}, (Conductor.crochet / 1000) * 0.15, {type: 1, onComplete: tween.onComplete, ease: FlxEase.quartIn}));
		}
		case 60: spinner.visible = true;
		FlxTween.cancelTweensOf(bf);
		bf.setPosition(0, 0);
		bf.setColorTransform();
	}
	if (camBeatStage >= 0) {
		camHUD.y += 10 + (camBeatStage > 0 ? 10 : 0);
		if (camBeatStage > 0) camHUD.angle = curBeat % 2 == 1 ? 2 : -2;
		if (camBeatStage > 1) {
			camGame.zoom += 0.06;
			camHUD.zoom += 0.06;
		}
		FlxTween.tween(camHUD, {y: 0, angle: 0}, Conductor.crochet / 1100, {ease: FlxEase.backOut});
	}
	bf.danceOnBeat = curBeat >= 0;
}
function setcamBeatStage() camBeatStage++;
function resetcamBeatStage() camBeatStage = 0;