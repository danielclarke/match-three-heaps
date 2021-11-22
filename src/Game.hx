import Player;

var TILE_SIZE = 16;

class Game {
    var s2d : h2d.Scene;
    var player : Player;
    var cells : Array<Array<h2d.Bitmap>>;

    public function new(s2d : h2d.Scene) {
        this.s2d = s2d;
        this.renderBg();
        var tile = h2d.Tile.fromColor(0x000000, TILE_SIZE - 1, TILE_SIZE - 1);
        this.cells = [for (i in 0 ... 6) [for (j in 0 ... 15) new h2d.Bitmap(tile, s2d)]];
        for (i in 0 ... 6) {
            for (j in 0 ... 15) {
                this.cells[i][j].x = i * TILE_SIZE + TILE_SIZE * 5;
                this.cells[i][j].y = j * TILE_SIZE;
            }
        }
        this.player = new Player(s2d);
    }

    public function update(dt : Float) {
        this.player.update(dt);
    }

    public function render() {
        
    }

    function renderBg() {
        for (i in 0 ... 16) {
            for (j in 0 ... 15) {
                var customGraphics = new h2d.Graphics(s2d);
                customGraphics.beginFill(0xFFFFFF);
                customGraphics.drawRect(i * TILE_SIZE, j * TILE_SIZE, TILE_SIZE - 1, TILE_SIZE - 1);
                customGraphics.endFill();
            }
        }
    }
}