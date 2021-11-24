import Player;

var TILE_SIZE = 16;

class Game {
	var s2d:h2d.Scene;
	var player:Player;
	var cells:Array<Array<h2d.Bitmap>>;

	public function new(s2d:h2d.Scene) {
		this.s2d = s2d;
		this.renderBg();
		var tile = h2d.Tile.fromColor(0x000000, TILE_SIZE - 1, TILE_SIZE - 1);
		this.cells = [for (i in 0...6) [for (j in 0...15) new h2d.Bitmap(tile, s2d)]];
		for (i in 0...6) {
			for (j in 0...15) {
				this.cells[i][j].x = i * TILE_SIZE + TILE_SIZE * 5;
				this.cells[i][j].y = j * TILE_SIZE;
				this.cells[i][j].alpha = 0;
			}
		}
		this.player = new Player(s2d);
	}

	public function update(dt:Float) {
		var x = Math.floor(this.player.x);
		var y = Math.ceil(this.player.y);
		var freeCells = [true, true, true, true, true];

		if (x == 0) {
			freeCells[0] = false;
			freeCells[1] = false;
		} else if (x == 5) {
			freeCells[3] = false;
			freeCells[4] = false;
		} else {
			freeCells[0] = this.cells[x - 1][y].alpha < 1;
			freeCells[3] = this.cells[x + 1][y].alpha < 1;
			if (y < 14) {
				freeCells[2] = this.cells[x][y + 1].alpha < 1;
				freeCells[1] = this.cells[x - 1][y + 1].alpha < 1;
				freeCells[4] = this.cells[x + 1][y + 1].alpha < 1;
			}
		}

		if (Math.floor(this.player.y) == 14) {
			this.handleCollision();
		}

		this.player.update(dt);
	}

	public function render() {}

	function handleCollision() {
		var x = Math.floor(this.player.x);
		var y = Math.ceil(this.player.y);

		this.cells[x][y - 2] = this.player.sprites[0];
		this.cells[x][y - 1] = this.player.sprites[1];
		this.cells[x][y] = this.player.sprites[2];

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
