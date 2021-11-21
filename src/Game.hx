import Player;

class Game {
    var s2d : h2d.Scene;
    var player : Player;

    public function new(s2d : h2d.Scene) {
        this.s2d = s2d;
        this.renderBg();
        this.player = new Player(s2d);
    }

    public function update(dt : Float) {
        this.player.update(dt);
    }

    public function render() {
        
    }

    function renderBg() {
        for (i in 0 ... 32) {
            for (j in 0 ... 30) {
                var customGraphics = new h2d.Graphics(s2d);
                customGraphics.beginFill(0xFFFFFF);
                customGraphics.drawRect(i * 8, j * 8, 7, 7);
                customGraphics.endFill();
            }
        }
    }
}