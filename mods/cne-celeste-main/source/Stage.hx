function pixelsToTiles(x, y) {
	return new FlxPoint(Math.floor(x / 8) + 1, Math.floor(y / 8) + 1);
}

function getRoomAtCoords(x, y, map):Dynamic {
	for (i in 0...map.rooms.length) {
		var room = map.rooms[i];
		if(x >= room.x && x <= room.x + room.width && y >= room.y && y <= room.y + room.height) {
			return room;
		}
	}

	return false;
}

/*
function utils.getFillerAtCoords(x, y, map)
	for i, filler in ipairs(map.fillers) do
		if x >= filler.x * 8 and x <= filler.x * 8 + filler.width * 8 and y >= filler.y * 8 and y <= filler.y * 8 + filler.height * 8 then
			return filler
		end
	end

	return false
end*/