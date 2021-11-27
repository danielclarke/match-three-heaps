import h2d.Tile;

var TILE_SIZE = 16;

enum Gem {
	None;
	Basic(color:Int);
	Bomb(color:Int);
}

// enum GemColors {
// 	Red;
// 	Green;
// 	Blue;
// 	Cyan;
// 	Magenta;
// 	Yellow;
// }

var Red:Int = 0xFF0000;
var Green:Int = 0x00FF00;
var Blue:Int = 0x0000FF;
var Cyan:Int = 0x00FFFF;
var Magenta:Int = 0xFF00FF;
var Yellow:Int = 0xFFFF00;
