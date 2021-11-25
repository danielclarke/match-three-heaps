import Player;
import Gem;

var TILE_SIZE = 16;

class Game {
	var s2d:h2d.Scene;
	var player:Player;
	var cells:Array<Array<Gem>>;
	var sprites:Array<Array<h2d.Bitmap>>;

	public function new(s2d:h2d.Scene) {
		this.s2d = s2d;
		this.renderBg();
		var tile = h2d.Tile.fromColor(0x000000, TILE_SIZE - 1, TILE_SIZE - 1);
		this.cells = [for (i in 0...6) [for (j in 0...15) null]];
		this.sprites = [for (i in 0...6) [for (j in 0...15) new h2d.Bitmap(tile, s2d)]];
		for (i in 0...6) {
			for (j in 0...15) {
				this.sprites[i][j].x = i * TILE_SIZE + TILE_SIZE * 5;
				this.sprites[i][j].y = j * TILE_SIZE;
				this.sprites[i][j].alpha = 0;
			}
		}
		this.player = new Player(s2d);
	}

	public function update(dt:Float) {
		var x = Math.floor(this.player.x);
		var y = Math.ceil(this.player.y);
		var freeCells = [true, true, true, true, true];

		// switch this.cells[0][0] {
		//     case null: trace("null case");
		//     case Red: trace("Red case");
		//     case _: trace("Other case");
		// }

		if (x == 0) {
			freeCells[0] = false;
			freeCells[1] = false;
		} else if (x == 5) {
			freeCells[3] = false;
			freeCells[4] = false;
		} else {
			freeCells[0] = this.sprites[x - 1][y].alpha < 1;
			freeCells[3] = this.sprites[x + 1][y].alpha < 1;
			if (y < 14) {
				freeCells[2] = this.sprites[x][y + 1].alpha < 1;
				freeCells[1] = this.sprites[x - 1][y + 1].alpha < 1;
				freeCells[4] = this.sprites[x + 1][y + 1].alpha < 1;
			}
		}

		if (Math.floor(player.y) == 14) {
			this.handleCollision();
		}
		this.player.update(dt, this.cells);
	}

	public function render() {}

	function handleCollision() {
		var x = Math.floor(this.player.x);
		var y = Math.floor(this.player.y);

		this.sprites[x][y - 2].tile = this.player.sprites[2].tile;
		this.sprites[x][y - 2].alpha = 1;
		this.cells[x][y - 2] = this.player.gems[2];
		this.sprites[x][y - 1].tile = this.player.sprites[1].tile;
		this.sprites[x][y - 1].alpha = 1;
		this.cells[x][y - 1] = this.player.gems[1];
		this.sprites[x][y].tile = this.player.sprites[0].tile;
		this.sprites[x][y].alpha = 1;
		this.cells[x][y] = this.player.gems[0];

		this.player.respawn();
	}

	function renderBg() {
		for (i in 0...16) {
			for (j in 0...15) {
				var customGraphics = new h2d.Graphics(s2d);
				if (5 <= i && i <= 10) {
					customGraphics.beginFill(0x000000);
				} else {
					customGraphics.beginFill(0xFFFFFF);
				}
				customGraphics.drawRect(i * TILE_SIZE, j * TILE_SIZE, TILE_SIZE - 1, TILE_SIZE - 1);
				customGraphics.endFill();
			}
		}
	}
}
