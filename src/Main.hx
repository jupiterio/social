
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
        
        // load all the graphics! Remember to add new graphics here!
        var parcel = new Parcel({
            "textures": [
                {"id":"assets/ui/bubble.png"},
                {"id":"assets/ui/profile.png"}
            ]
        });
        
        // get a simple loading screen for all that stuff. Builtin will do
        new ParcelProgress({
            parcel: parcel,
            background: new Color().rgb(0xf94b04),
            oncomplete: assets_loaded // replacement for ready() since we're using it for the parcel,
            // and since it loads asynchronously
        });
        
        // load it!
        parcel.load();
    }
    
    function assets_loaded(_) { // we're ready to use all that stuff!
        // setup the mint canvas {
        rendering = new LuxeMintRender();
        
        var autocanvas = new AutoCanvas(Luxe.camera.view, {
            name:"canvas",
            rendering: rendering,
            options: { color:new Color(1,1,1,0.0) },
            scale: 1,
            x: 0, y:0, w: Luxe.screen.w, h: Luxe.screen.h
        });
        autocanvas.auto_listen();
        canvas = autocanvas; // turn that thing into an actual canvas!
        
        focus = new Focus(canvas); // apparently this is necessary
        // } mint canvas setup'd
        
        // example bubble menu. It's probably gonna be the final bubble menu tho
        var bubbles = new entities.BubbleMenu({
            parent: canvas,
            name: "Toolbar",
            zooming: 8,
            x: 10, y:10, h:180
        }, [
            {
                name: "Profile",
                icon: "assets/ui/profile.png",
                onclicked: function(_,_) { trace("Profile clicked!"); }
            }/*,
            {
                name: "Inbox",
                onclicked: function(_,_) { trace("Inbox clicked!"); }
            },
            {
                name: "Feed",
                onclicked: function(_,_) { trace("Feed clicked!"); }
            },
            {
                name: "Map",
                onclicked: function(_,_) { trace("Map clicked!"); }
            },
            {
                name: "LogOut",
                onclicked: function(_,_) { trace("LogOut clicked!"); }
            }*/
        ]);
        
        var ProfileWindow = new entities.ContentWindow({
            parent: canvas,
            x: 66,
            name: "ProfileWindow",
            title: "Profile"
        });
    }

    override function onkeyup(event:KeyEvent) {
        if(event.keycode == Key.escape) {
            Luxe.shutdown();
        }
    }

    override function update(delta:Float) {
        
    }

}
