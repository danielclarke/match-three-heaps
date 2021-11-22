import hxd.Math;
import hxd.Key;

var TILE_SIZE = 16;

class Player {

    var sprites: Array<h2d.Bitmap>;
    var speedY: Float;
    var x: Float;
    var y: Float;
    var elapsedTime: Float;
    var leftDown: Bool;
    var rightDown: Bool;
    var upDown: Bool;
    var downDown: Bool;
    var leftTime: Float;
    var rightTime: Float;
    var upTime: Float;
    var downTime: Float;

    public function new(s2d : h2d.Scene) {
        this.sprites = [
            new h2d.Bitmap(h2d.Tile.fromColor(0xFF0000, TILE_SIZE, TILE_SIZE), s2d),
            new h2d.Bitmap(h2d.Tile.fromColor(0x00FF00, TILE_SIZE, TILE_SIZE), s2d),
            new h2d.Bitmap(h2d.Tile.fromColor(0x0000FF, TILE_SIZE, TILE_SIZE), s2d),
        ];
        this.x = 0;
        this.y = 0;
        this.render();
        this.speedY = 5;
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

    public function update(dt : Float) {
        this.elapsedTime += dt;
        this.leftTime += dt;
        this.rightTime += dt;
        this.upTime += dt;
        this.downTime += dt;

        if (leftTime > 0.1 && Key.isDown(Key.LEFT)) {
            this.leftDown = true;
            leftTime = 0;
        }
        if (rightTime > 0.1 && Key.isDown(Key.RIGHT)) {
            this.rightDown = true;
            rightTime = 0;
        }
        if (upTime > 0.1 && Key.isDown(Key.UP)) {
            this.upDown = true;
            upTime = 0;
        }
        if (Key.isDown(Key.DOWN)) {
            this.speedY = 500;
        }
        
        if (this.leftDown) {
            this.x -= TILE_SIZE;
        }
        if (this.rightDown) {
            this.x += TILE_SIZE;
        }
        if (this.upDown) {
            this.cycle();
        }

        this.leftDown = false;
        this.rightDown = false;
        this.upDown = false;
        
        this.y += this.speedY * dt;
        this.x = Math.min(this.x, 256 - TILE_SIZE * 6);
        this.x = Math.max(this.x, TILE_SIZE * 5);
        this.y = Math.min(this.y, 240 - TILE_SIZE);
        this.y = Math.max(this.y, 0);
        if (this.y >= 240 - TILE_SIZE * 3) {
            this.y = 240 - TILE_SIZE * 3;
        }
        this.render();
    }

    public function render() {
        for (i in [0, 1, 2]) {
            this.sprites[i].x = this.x;
            this.sprites[i].y = this.y + i * TILE_SIZE;
        }
    }

    function cycle() {
        this.sprites = [
            this.sprites[1],
            this.sprites[2],
            this.sprites[0]
        ];
    }
}