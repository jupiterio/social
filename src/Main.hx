
import luxe.GameConfig;
import luxe.Input;

import luxe.Color;
import luxe.Vector;

import luxe.Text;
import luxe.Sprite;

import luxe.Parcel;
import luxe.ParcelProgress;


import mint.Control;
import mint.render.luxe.LuxeMintRender;
import mint.focus.Focus;

import AutoCanvas;

class Main extends luxe.Game {
    
    public static var canvas: mint.Canvas;
    public static var rendering: LuxeMintRender;
    public static var focus: Focus;
    
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
            ]
        });
        
        new ParcelProgress({
            parcel: parcel,
            background: new Color().rgb(0xf94b04),
            oncomplete: assets_loaded
        });
        
        parcel.load();
    }
    
    var bubbles : entities.BubbleMenu;
    
    function assets_loaded(_) {
        Luxe.renderer.clear_color.rgb(0x121219);
        
        rendering = new LuxeMintRender();
        
        var autocanvas = new AutoCanvas(Luxe.camera.view, {
            name:"canvas",
            rendering: rendering,
            options: { color:new Color(1,1,1,0.0) },
            scale: 1,
            x: 0, y:0, w: Luxe.screen.w, h: Luxe.screen.h
        });
        autocanvas.auto_listen();
        canvas = autocanvas;
        
        focus = new Focus(canvas);
        
        bubbles = new entities.BubbleMenu({
            parent: canvas,
            name: "Toolbar",
            x: 10, y:10, w: 58, h:180
        }, [
            {
                name: "Profile",
                onclicked: function(_,_) { trace("Profile clicked!"); }
            },
            {
                name: "Map",
                onclicked: function(_,_) { trace("Map clicked!"); }
            },
            {
                name: "LogOut",
                onclicked: function(_,_) { trace("LogOut clicked!"); }
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

}
