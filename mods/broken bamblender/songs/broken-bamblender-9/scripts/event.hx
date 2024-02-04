var playerHitNotes = 0;
var cpuHitNotes = 0;
var playerHitNotesText = new FlxText(0, 690, 1270, "notes hit: ", 24);
var cpuHitNotesText = new FlxText(0, 690, 0, "notes hit: ", 24);
playerHitNotesText.alignment = "right";
function postCreate() {
	strumLines.members[1].cpu = true;
	trace(strumLines.members[0].notes.length);
	playerHitNotesText.camera = cpuHitNotesText.camera = camHUD;
	add(playerHitNotesText);
	add(cpuHitNotesText);
}
function onDadHit(event) {
	if (strumLines.members.indexOf(event.note.strumLine) == 0) cpuHitNotesText.text = "notes hit: " + ++cpuHitNotes;
	else playerHitNotesText.text = "notes hit: " + ++playerHitNotes;
}
