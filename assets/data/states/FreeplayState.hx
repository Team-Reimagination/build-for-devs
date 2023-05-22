import funkin.backend.chart.Chart;
function update(elapsed) {
	if (FlxG.keys.justPressed.P) {
		var doble = Chart.parse(songs[curSelected].name, songs[curSelected].difficulties[curDifficulty]);
		trace(Json.stringify(doble));
	}
}