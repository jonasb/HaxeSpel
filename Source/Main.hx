package;

import flash.display.Sprite;

class Main extends Sprite {
    var spelare:Sprite;

    public function new() {
        super();

        // skapa spelaren
        spelare = new Sprite();
        addChild(spelare);
        ritaSpelare();
        // starta spelaren i mitten av spelet
        spelare.x = stage.stageWidth / 2;
        spelare.y = stage.stageHeight / 2;
    }

    function ritaSpelare() {
        var g = spelare.graphics;
        // rita kroppen
        g.beginFill(0xFF0000); // rött
        g.drawCircle(0, 0, 20);

        // rita ögon
        g.beginFill(0x000000); // svart
        g.drawEllipse(-7, -23, 14, 10); // bakgrund
        g.beginFill(0xFFFFFF); // vitt
        g.drawCircle(-4, -19, 1.5);
        g.drawCircle(4, -19, 1.5);

        // rita prickar
        g.beginFill(0x000000); // svart
        g.drawCircle(0, -9, 2);
        g.drawCircle(-8, -4, 2);
        g.drawCircle(8, -4, 2);
        g.drawCircle(-4, 3, 2);
        g.drawCircle(4, 3, 2);
        g.drawCircle(-7, 10, 2);
        g.drawCircle(7, 10, 2);
    }
}
