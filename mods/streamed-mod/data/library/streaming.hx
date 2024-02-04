import haxe.crypto.Md5;
import lime.utils.AssetLibrary;
import lime.utils.Assets as LimeAssets;
import funkin.backend.assets.ModsFolder;

import lime.media.AudioBuffer;
import lime.graphics.Image;
import lime.text.Font;
import haxe.io.Path;
import Reflect;
import lime.text.Font;
//import lime.utils.Bytes;

//import sys.FileStat;
import sys.FileSystem;
import haxe.Json;
import sys.Http;

var uploader = "Frakits";
var repo = "test-mod";
var branch = "main";

var index = null;

var replace = StringTools.replace;

function getUrl(file:String) {
	file = StringTools.urlEncode(file);
	file = replace(file, "%2F", "/");
	file = replace(file, "%2f", "/");
	return "https://niirou.se/testfnf/zardy/" + file;
	//return "https://raw.githubusercontent.com/"+uploader+"/"+repo+"/"+branch+"/" + file;
}

var files = [];
var logging = true;

if(!hasLibFunction) {
	__script__.variables.set("modName", "");
}

function create() {
	this.prefix = "assets/";
	this.folderPath = ModsFolder.modsPath + ModsFolder.currentModFolder;
	modName = repo;
	this.libName = repo;

	trace("Hello", modName);

	index = Json.parse(Http.requestUrl(getUrl("index.json")));

	trace(index);

	files = Reflect.fields(index);
	loadedModName = modName;

	//trace(__getFiles("assets/songs", true));
}

function getEditedTime(asset) { // lol not used by actual game
	return Reflect.field(index, asset).e * 1000;
}

function exists(asset, type) {
	//trace(asset, type);
	return __parseAsset(asset);
}

function getAssetPath() {
	return _parsedAsset;
}

function __parseAsset(asset:String):Bool {
	if (!StringTools.startsWith(asset)) return false;
	_parsedAsset = asset.substr(prefix.length);

	if(hasLibFunction && ModsFolder.useLibFile) {
		var file = new Path(_parsedAsset);
		if(StringTools.startsWith(file.file, "LIB_")) {
			var library = file.file.substr(4);
			if(library != modName) return false;

			_parsedAsset = file.dir + "." + file.ext;
		}
	}

	if(Reflect.hasField(index, getAssetPath())) {
		trace(_parsedAsset);
		//trace(Reflect.field(index, getAssetPath()));
		return true;
	}
	return false;
}

var audioCache:Map<String, Bytes> = [];

function getAudioBuffer(id:String):AudioBuffer {
	if (!exists(id, "SOUND"))
		return NULL;
	if(audioCache.exists(id)) {
		var bb = audioCache.get(id);
		return AudioBuffer.fromBytes(bb);
	}
	var path = getAssetPath();
	editedTimes[id] = getEditedTime(path);
	trace(path);
	// TODO: important add a cache
	var bb = requestBytes(getUrl(path));
	var e = AudioBuffer.fromBytes(bb);
	// LimeAssets.cache.audio.set('$libName:$id', e);
	audioCache.set(id, bb);
	return e;
}

var binaryCache:Map<String, Bytes> = [];

function getBytes(id:String):Bytes {
	if (!exists(id, "BINARY"))
		return NULL;
	if(binaryCache.exists(id))
		return binaryCache.get(id);
	var path = getAssetPath();
	editedTimes[id] = getEditedTime(path);
	var e = requestBytes(getUrl(path));
	binaryCache.set(id, e);
	return e;
}

var fontCache:Map<String, Bytes> = [];

function getFont(id:String):Font {
	if (!exists(id, "FONT"))
		return NULL;
	if(fontCache.exists(id)) {
		return ModsFolder.registerFont(Font.fromBytes(fontCache.get(id)));
	}
	var path = getAssetPath();
	editedTimes[id] = getEditedTime(path);
	var e = requestBytes(getUrl(path));
	fontCache.set(id, e);
	return ModsFolder.registerFont(Font.fromBytes(e));
}

var imageCache:Map<String, Bytes> = [];

function getImage(id:String):Image {
	if (!exists(id, "IMAGE"))
		return NULL;
	if(imageCache.exists(id)) {
		var bb = imageCache.get(id);
		return Image.fromBytes(bb);
	}
	var path = getAssetPath();
	editedTimes[id] = getEditedTime(path);

	var bb = requestBytes(getUrl(path));
	var e = Image.fromBytes(bb);
	imageCache.set(id, bb);
	return e;
}

function __getFiles(folder:String, folders:Bool = false) {
	if (!StringTools.endsWith(folder, "/")) folder = folder + "/";
	if (__parseAsset(folder)) {
		var path = getAssetPath();
		try {
			var result:Array<String> = [];
			for(e in files) {
				if(StringTools.startsWith(e, path)) {
					trace(e, path, Reflect.field(index, e), folders);
					var aa = e.substr(path.length);
					if(aa.length == 0) continue;
					if(aa.indexOf("/") != aa.lastIndexOf("/")) // checks for multiple /
						continue;

					if(Reflect.field(index, e).d == folders) {
						result.push(replace(aa, "/", ""));
					}
				}
			}
			return result;
		} catch(e:Exception) {
			trace(e);
			// woops!!
		}
	}
	return [];
}

function __isCacheValid(cache:Map<String, Dynamic>, asset:String, isLocalCache:Bool = false) {
	if (!editedTimes.exists(asset))
		return false;

	if (editedTimes[asset] == null || editedTimes[asset] < getEditedTime(getPath(asset))) {
		return false;
	}

	if (!isLocalCache) asset = '$libName:$asset';

	return cache.exists(asset) && cache[asset] != null;
}



// utils
function requestBytes(url:String):Bytes {
	var h = new Http(url);
	var r = null;
	h.onBytes = function(d) {
		r = d;
	}
	h.onError = function(e) {
		trace(url);
		throw e;
	}
	h.request(false);
	return r;
}