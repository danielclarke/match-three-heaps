import haxe.ds.Map;
import hxd.Math;
import hxd.Key;
import Gem;

var TILE_SIZE = 16;

class Player {
	public var x:Float;
	public var y:Float;
	public var gems:Array<Gem>;
	public var sprites:Array<h2d.Bitmap>;
	public var speedY:Float;

	var tiles:Map<Int, h2d.Tile>;
	var elapsedTime:Float;
	var leftDown:Bool;
	var rightDown:Bool;
	var upDown:Bool;
	var downDown:Bool;
	var leftTime:Float;
	var rightTime:Float;
	var upTime:Float;
	var downTime:Float;

	public function new(s2d:h2d.Scene) {
		this.tiles = [
			Red => h2d.Tile.fromColor(0xFF0000, TILE_SIZE, TILE_SIZE),
			Green => h2d.Tile.fromColor(0x00FF00, TILE_SIZE, TILE_SIZE),
			Blue => h2d.Tile.fromColor(0x0000FF, TILE_SIZE, TILE_SIZE),
			Cyan => h2d.Tile.fromColor(0x00FFFF, TILE_SIZE, TILE_SIZE),
			Magenta => h2d.Tile.fromColor(0xFF00FF, TILE_SIZE, TILE_SIZE),
			Yellow => h2d.Tile.fromColor(0xFFFF00, TILE_SIZE, TILE_SIZE),
		];

		this.gems = [Basic(Red), Basic(Green), Basic(Blue)];
		this.sprites = [
			new h2d.Bitmap(tiles[Red], s2d),
			new h2d.Bitmap(tiles[Green], s2d),
			new h2d.Bitmap(tiles[Blue], s2d),
		];
		this.x = 0;
		this.y = 0;
		this.render();
		this.speedY = 1;
		this.elapsedTime = 0;
		this.leftDown = false;
		this.rightDown = false;
		this.upDown = false;
		this.downDown = false;
		this.leftTime = 0;
		this.rightTime = 0;
		this.upTime = 0;
		this.downTime = 0;
	}

	public function update(dt:Float, cells:Array<Array<Gem>>) {
		var x = Math.floor(this.x);
		var y = Math.ceil(this.y);
		var freeCells = [true, true, true, true, true];

		if (x == 0) {
			freeCells[0] = false;
			freeCells[1] = false;
		} else if (x == 5) {
			freeCells[3] = false;
			freeCells[4] = false;
		} else {
			freeCells[0] = cells[x - 1][y] == None;
			freeCells[4] = cells[x + 1][y] == None;
		}

		this.elapsedTime += dt;
		this.leftTime += dt;
		this.rightTime += dt;
		this.upTime += dt;
		this.downTime += dt;

		if (leftTime > 0.1 && Key.isDown(Key.LEFT) && freeCells[0]) {
			this.leftDown = true;
			leftTime = 0;
		}
		if (rightTime > 0.1 && Key.isDown(Key.RIGHT) && freeCells[4]) {
			this.rightDown = true;
			rightTime = 0;
		}
		if (upTime > 0.1 && Key.isDown(Key.UP)) {
			this.upDown = true;
			upTime = 0;
		}

		if (this.leftDown) {
			this.x -= 1;
		}
		if (this.rightDown) {
			this.x += 1;
		}
		if (this.upDown) {
			this.cycle();
		}

		x = Math.floor(this.x);
		if (y < 14) {
			freeCells[2] = cells[x][y] == None;
		} else {
			freeCells[2] = false;
		}
		if (!freeCells[2]) {
			this.speedY = 0;
			// this.y = Math.ceil(this.y);
		} else if (Key.isDown(Key.DOWN)) {
			this.speedY = 50;
		}

		this.leftDown = false;
		this.rightDown = false;
		this.upDown = false;

		this.y += this.speedY * dt;
		this.x = Math.min(this.x, 5);
		this.x = Math.max(this.x, 0);
		this.y = Math.max(this.y, -1);
		this.y = Math.min(this.y, 14);

		trace(this.y);

		this.render();
	}

	public function render() {
		for (i in [0, 1, 2]) {
			this.sprites[i].x = (this.x + 5) * TILE_SIZE;
			this.sprites[i].y = (this.y - i) * TILE_SIZE;
			switch this.gems[i] {
				case Basic(color):
					{
						this.sprites[i].tile = tiles[color];
					}
				case Bomb(color):
					{}
				case None:
					{}
			}
		}
	}

	public function respawn() {
		this.x = 0;
		this.y = 0;
		this.speedY = 1;
	}

	function cycle() {
		this.gems = [this.gems[2], this.gems[0], this.gems[1]];
	}
}
