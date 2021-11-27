import Player;
import Gem;

var TILE_SIZE = 16;

class Game {
	var s2d:h2d.Scene;
	var player:Player;
	var cells:Array<Array<Gem>>;
	var sprites:Array<Array<h2d.Bitmap>>;
	var tiles:Map<Int, h2d.Tile>;

	public function new(s2d:h2d.Scene) {
		this.tiles = [
			Red => h2d.Tile.fromColor(0xFF0000, TILE_SIZE, TILE_SIZE),
			Green => h2d.Tile.fromColor(0x00FF00, TILE_SIZE, TILE_SIZE),
			Blue => h2d.Tile.fromColor(0x0000FF, TILE_SIZE, TILE_SIZE),
			Cyan => h2d.Tile.fromColor(0x00FFFF, TILE_SIZE, TILE_SIZE),
			Magenta => h2d.Tile.fromColor(0xFF00FF, TILE_SIZE, TILE_SIZE),
			Yellow => h2d.Tile.fromColor(0xFFFF00, TILE_SIZE, TILE_SIZE),
		];

		this.s2d = s2d;
		this.renderBg();
		var tile = h2d.Tile.fromColor(0x000000, TILE_SIZE - 1, TILE_SIZE - 1);
		this.cells = [for (i in 0...6) [for (j in 0...15) None]];
		this.sprites = [for (i in 0...6) [for (j in 0...15) new h2d.Bitmap(tile, s2d)]];
		// this.cells[0][6] = Basic(Red);
		// this.cells[1][6] = Basic(Green);
		// this.cells[2][6] = Basic(Blue);
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
		if (player.speedY == 0) {
			this.handleCollision();
		}
		this.player.update(dt, this.cells);
		this.render();
	}

	function handleCollision() {
		var x = Math.floor(this.player.x);
		var y = Math.floor(this.player.y);

		if (y - 2 >= 0) {
			this.cells[x][y - 2] = this.player.gems[2];
		}
		if (y - 1 >= 0) {
			this.cells[x][y - 1] = this.player.gems[1];
		}
		if (y >= 0) {
			this.cells[x][y] = this.player.gems[0];
		}

		this.player.respawn();
	}

	public function render() {
		for (i in 0...6) {
			for (j in 0...15) {
				switch this.cells[i][j] {
					case Basic(color):
						{
							this.sprites[i][j].tile = tiles[color];
							this.sprites[i][j].alpha = 1;
						}
					case Bomb(color):
						{}
					case None:
						{
							this.sprites[i][j].alpha = 0;
						}
				}
			}
		}
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
