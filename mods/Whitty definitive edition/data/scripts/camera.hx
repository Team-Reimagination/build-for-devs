var cameraFollow:FlxSprite = new FlxSprite();
function postCreate () {
	add(cameraFollow);
	FlxG.camera.follow(cameraFollow);
	cameraFollow.visible = false;
	cameraFollow.setPosition(camFollow.x, camFollow.y);
}
var driftAmount:Float = 50;
var speedIthink = 0.8;
var animName = "";
function postUpdate(elapsed) {
	if (!["danceLeft", "danceRight", "idle"].contains(boyfriend.animation.curAnim.name))
		if (curSection.mustHitSection) animName = boyfriend.animation.curAnim.name;
	if (!["danceLeft", "danceRight", "idle"].contains(dad.animation.curAnim.name))
		if (!curSection.mustHitSection) animName = dad.animation.curAnim.name;

	if (['singLEFT', 'singLEFT-end'].contains(animName)) camFollow.x -= 50;
	if (['singRIGHT', 'singRIGHT-end'].contains(animName)) camFollow.x += 50;
	if (['singUP', 'singUP-end'].contains(animName)) camFollow.y -= 50;
	if (['singDOWN', 'singDOWN-end'].contains(animName)) camFollow.y += 50;
	var realSpeed = FlxG.camera.followLerp;
	cameraFollow.acceleration.set(((camFollow.x - cameraFollow.x) - (cameraFollow.velocity.x * speedIthink)) / realSpeed, ((camFollow.y - cameraFollow.y) - (cameraFollow.velocity.y * speedIthink)) / realSpeed);
}
public static function enableSmoothFollow(on:Bool, lerp = 0.04) {
	if (on) {FlxG.camera.follow(cameraFollow); cameraFollow.setPosition(camFollow.x, camFollow.y);} else{
		FlxG.camera.follow(camFollow);
		FlxG.camera.followLerp = lerp;
	} 
}
public static function setMotionThing(float:Float) {
	driftAmount = float;
}