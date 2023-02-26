import flx3d.Flx3DView;

var publicMesh = null;
var rotateY:Float = 0;
var rotateZ:Float = 0;
public var view3D:Flx3DView;
var controlPower:Float = 0.01;
var time:Float = 0;
function update(elapsed:Float) {
    time += elapsed;
    if (publicMesh != null) {
        if (controls.NOTE_LEFT) rotateY += 25;
        if (controls.NOTE_RIGHT) rotateY -= 25;
        if (controls.NOTE_UP) rotateZ += 25;
        if (controls.NOTE_DOWN) rotateZ -= 25;
        if (FlxG.keys.justPressed.SPACE) {
            rotateZ = rotateY = 0;
        }
        if (FlxG.keys.pressed.CONTROL) {
            controlPower += controlPower / 20;
            view3D.y -= controlPower;
            rotateY += controlPower * 20;
        }
        //rotateZ = lerp(rotateZ, 0, 0.1);
        //rotateY = lerp(rotateY, 0, 0.1);
        publicMesh.rotationY = lerp(publicMesh.rotationY, rotateY, 0.1);
        publicMesh.rotationX = lerp(publicMesh.rotationX, rotateZ, 0.1);
        //publicMesh.scaleX = publicMesh.scaleY = publicMesh.scaleZ = lerp(publicMesh.scaleX, 15, 0.1);
        publicMesh.scaleX = 25 + Math.sin(time) * 25;
        publicMesh.scaleY = 25 + Math.sin(1.2 * time) * 25;
    }
}
function postCreate() {
    view3D = new Flx3DView(0, 0, FlxG.width * 1.5, FlxG.height * 1.5);
    view3D.screenCenter();
    view3D.x += 250;
    view3D.y += 125;
    insert(members.indexOf(boyfriend), view3D);
    view3D.addModel(Paths.obj("seeze uncentered"), function(mesh){
        mesh.asset.x = mesh.asset.y = 0;
       	mesh.asset.y = -300;
        mesh.asset.scale(15);
        mesh.asset.rotationY = 0;
		trace(mesh.asset.assetType);
        publicMesh = view3D.meshes[0];
        FlxG.log.error("mesh added i think");
    }, Paths.image("sz"), false);
}
//function beatHit(curBeat) {
//    publicMesh.scaleX = 20;
//}