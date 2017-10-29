
import luxe.GameConfig;
import luxe.Input;

import luxe.Color;
import luxe.Vector;

import luxe.Sprite;
import entities.Bubble;

import luxe.Parcel;
import luxe.ParcelProgress;

class Main extends luxe.Game {
    
    override function config(config:GameConfig) {        
        config.window.title = "Social";
        config.window.width = 800;
        config.window.height = 600;
        config.window.fullscreen = false;
        
        return config;
    }

    override function ready() {
        var parcel = new Parcel({
            "textures": [
                {"id":"assets/ui/bubble.png"}
            ],
            "texts": [
                {"id":"assets/ui/bubble.svg"}
            ]
        });
        
        new ParcelProgress({
            parcel: parcel,
            background: new Color().rgb(0xf94b04),
            oncomplete: assets_loaded
        });
        
        parcel.load();
    }
    
    function assets_loaded(_) {        
        var bubbleMenu = new entities.BubbleMenu({
            name: "Toolbar",
            pos: new Vector(32,32)
        });
        
        bubbleMenu.startup([
            {
                name: "Profile",
                icon: Luxe.resources.texture("assets/ui/bubble.png"),
                clicked: function(event:MouseEvent) { trace("Profile clicked"); }
            },
            {
                name: "Map",
                icon: Luxe.resources.texture("assets/ui/bubble.png"),
                clicked: function(event:MouseEvent) { trace("Map clicked"); }
            },
            {
                name: "LogOut",
                icon: Luxe.resources.texture("assets/ui/bubble.png"),
                clicked: function(event:MouseEvent) { trace("LogOut clicked"); }
            }
        ]);
    }

    override function onkeyup(event:KeyEvent) {
        if(event.keycode == Key.escape) {
            Luxe.shutdown();
        }
    }

    override function update(delta:Float) {
        
    }

} //Main
