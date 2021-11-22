import h2d.Camera;
import hxd.Rand;
import Game;

class Main extends hxd.App {
    var frameRateLabel : h2d.Text;
    var updateRate : Float;
    var elapsedTime : Float;
    var game : Game;

    override function init() {
        updateRate = 24;
        elapsedTime = 0;

        var window = hxd.Window.getInstance();
        var camera = s2d.interactiveCamera;
        camera.setViewport(0, 0, 256, 240);
        camera.clipViewport = true;
        // camera.scaleX = s2d.width / 256;
        // camera.scaleY = s2d.height / 240;

        // function onResize() {
        //     camera.scaleX = s2d.width / 256;
        //     camera.scaleY = s2d.height / 240;
        // }

        // window.addResizeEvent(onResize);

        var customGraphics = new h2d.Graphics(s2d);
        customGraphics.beginFill(0xEA8220);
        customGraphics.drawRect(0, 0, 300, 300);
        customGraphics.endFill();

        var customGraphics2 = new h2d.Graphics(s2d);
        customGraphics2.beginFill(0xFFAA00);
        customGraphics2.drawRect(200, 200, 300, 300);
        customGraphics2.endFill();

        var date = Date.now();
        var rand = new Rand(date.getFullYear() + date.getMonth() + date.getDate() + date.getHours() + date.getMinutes() + date.getSeconds());

        game = new Game(s2d);
            
        frameRateLabel = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        frameRateLabel.color = new h3d.Vector(0, 0, 0, 1);
    }

    override function update(dt : Float) {
        var camera = s2d.interactiveCamera;
        frameRateLabel.text = Std.string(1.0 / dt);
        game.update(dt);

        elapsedTime += dt;
        if (elapsedTime >= 1.0 / updateRate) {
            elapsedTime = 0;
            
        }
    }

    static function main() {
        new Main();
    }
}