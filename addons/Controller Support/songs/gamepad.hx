import funkin.backend.system.Controls.Control;
function postCreate() {
	for (i in strumLines.members) {
		i.controls.bindButtons(Control.NOTE_LEFT, 0, [17]);
		i.controls.bindButtons(Control.NOTE_DOWN, 0, [4]);
		i.controls.bindButtons(Control.NOTE_UP, 0, [5]);
		i.controls.bindButtons(Control.NOTE_RIGHT, 0, [18]);
	}
	trace("H");
}
