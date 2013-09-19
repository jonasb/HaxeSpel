package;

import flash.events.Event;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;
import flash.display.Sprite;

class Main extends Sprite {
    var spelare:Sprite;
    var upp:Bool;
    var ner:Bool;
    var vanster:Bool;
    var hoger:Bool;

    public function new() {
        super();

        // skapa spelaren
        spelare = new Sprite();
        addChild(spelare);
        ritaSpelare();
        // starta spelaren i mitten av spelet
        spelare.x = stage.stageWidth / 2;
        spelare.y = stage.stageHeight / 2;

        // prenumerera på events
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
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

    function onKeyDown(event:KeyboardEvent) {
        switch (event.keyCode) {
            case Keyboard.UP: upp = true;
            case Keyboard.DOWN: ner = true;
            case Keyboard.LEFT: vanster = true;
            case Keyboard.RIGHT: hoger = true;
        }
    }

    function onKeyUp(event:KeyboardEvent) {
        switch (event.keyCode) {
            case Keyboard.UP: upp = false;
            case Keyboard.DOWN: ner = false;
            case Keyboard.LEFT: vanster = false;
            case Keyboard.RIGHT: hoger = false;
        }
    }

    function onEnterFrame(event:Event) {
        if (upp) {
            spelare.y -= 3;
        }
        if (ner) {
            spelare.y += 3;
        }
        if (vanster) {
            spelare.x -= 3;
        }
        if (hoger) {
            spelare.x += 3;
        }
    }
}
